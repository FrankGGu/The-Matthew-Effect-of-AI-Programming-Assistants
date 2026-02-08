import java.util.*;

class Solution {
    public boolean isPrintable(int[][] targetGrid) {
        int N = targetGrid.length;
        int M = targetGrid[0].length;

        int MAX_COLOR = 60;

        int[] min_r = new int[MAX_COLOR + 1];
        int[] max_r = new int[MAX_COLOR + 1];
        int[] min_c = new int[MAX_COLOR + 1];
        int[] max_c = new int[MAX_COLOR + 1];
        boolean[] is_present = new boolean[MAX_COLOR + 1];

        // Initialize min/max coordinates
        Arrays.fill(min_r, N);
        Arrays.fill(min_c, M);
        Arrays.fill(max_r, -1);
        Arrays.fill(max_c, -1);

        // Step 1: Find bounding boxes for each color and mark present colors
        for (int r = 0; r < N; r++) {
            for (int c = 0; c < M; c++) {
                int color = targetGrid[r][c];
                is_present[color] = true;
                min_r[color] = Math.min(min_r[color], r);
                max_r[color] = Math.max(max_r[color], r);
                min_c[color] = Math.min(min_c[color], c);
                max_c[color] = Math.max(max_c[color], c);
            }
        }

        // Step 2: Build the dependency graph
        List<Integer>[] adj = new ArrayList[MAX_COLOR + 1];
        int[] inDegree = new int[MAX_COLOR + 1];
        boolean[][] visitedEdges = new boolean[MAX_COLOR + 1][MAX_COLOR + 1]; // To prevent duplicate edges

        for (int i = 1; i <= MAX_COLOR; i++) {
            adj[i] = new ArrayList<>();
        }

        int present_colors_count = 0;
        for (int color1 = 1; color1 <= MAX_COLOR; color1++) {
            if (!is_present[color1]) {
                continue;
            }
            present_colors_count++;

            // Iterate through the bounding box of color1
            for (int r = min_r[color1]; r <= max_r[color1]; r++) {
                for (int c = min_c[color1]; c <= max_c[color1]; c++) {
                    int color2 = targetGrid[r][c];
                    if (color1 != color2 && !visitedEdges[color1][color2]) {
                        // If a cell within color1's bounding box is color2,
                        // then color1 must have been printed before color2.
                        adj[color1].add(color2);
                        inDegree[color2]++;
                        visitedEdges[color1][color2] = true;
                    }
                }
            }
        }

        // Step 3: Perform topological sort (Kahn's algorithm)
        Queue<Integer> q = new LinkedList<>();
        for (int color = 1; color <= MAX_COLOR; color++) {
            if (is_present[color] && inDegree[color] == 0) {
                q.offer(color);
            }
        }

        int processed_count = 0;
        while (!q.isEmpty()) {
            int u = q.poll();
            processed_count++;

            for (int v : adj[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // If all present colors were processed, no cycle was found, so it's printable.
        return processed_count == present_colors_count;
    }
}