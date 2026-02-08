import java.util.*;

class Solution {
    public int[] shortestAlternatingPaths(int n, int[][] redEdges, int[][] blueEdges) {
        List<List<Integer>> redAdj = new ArrayList<>();
        List<List<Integer>> blueAdj = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            redAdj.add(new ArrayList<>());
            blueAdj.add(new ArrayList<>());
        }

        for (int[] edge : redEdges) {
            redAdj.get(edge[0]).add(edge[1]);
        }

        for (int[] edge : blueEdges) {
            blueAdj.get(edge[0]).add(edge[1]);
        }

        int[] result = new int[n];
        Arrays.fill(result, -1);
        result[0] = 0;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, -1}); // node, distance, color (0: red, 1: blue, -1: none)

        boolean[][] visited = new boolean[n][2]; // [node][color]
        visited[0][0] = true;
        visited[0][1] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int node = curr[0];
            int dist = curr[1];
            int color = curr[2];

            if (color != 0) {
                for (int neighbor : redAdj.get(node)) {
                    if (!visited[neighbor][0]) {
                        visited[neighbor][0] = true;
                        if (result[neighbor] == -1) {
                            result[neighbor] = dist + 1;
                        }
                        queue.offer(new int[]{neighbor, dist + 1, 0});
                    }
                }
            }

            if (color != 1) {
                for (int neighbor : blueAdj.get(node)) {
                    if (!visited[neighbor][1]) {
                        visited[neighbor][1] = true;
                        if (result[neighbor] == -1) {
                            result[neighbor] = dist + 1;
                        }
                        queue.offer(new int[]{neighbor, dist + 1, 1});
                    }
                }
            }
        }

        return result;
    }
}