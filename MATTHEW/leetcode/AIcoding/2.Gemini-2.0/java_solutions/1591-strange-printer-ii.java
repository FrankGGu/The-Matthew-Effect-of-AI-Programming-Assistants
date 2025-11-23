import java.util.*;

class Solution {
    public boolean isPrintable(int[][] targetGrid) {
        int m = targetGrid.length, n = targetGrid[0].length;
        int k = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                k = Math.max(k, targetGrid[i][j]);
            }
        }

        int[] up = new int[k + 1], down = new int[k + 1], left = new int[k + 1], right = new int[k + 1];
        Arrays.fill(up, m);
        Arrays.fill(left, n);

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int color = targetGrid[i][j];
                up[color] = Math.min(up[color], i);
                down[color] = Math.max(down[color], i);
                left[color] = Math.min(left[color], j);
                right[color] = Math.max(right[color], j);
            }
        }

        List<Integer>[] adj = new List[k + 1];
        for (int i = 1; i <= k; i++) {
            adj[i] = new ArrayList<>();
        }

        int[] indegree = new int[k + 1];

        for (int color1 = 1; color1 <= k; color1++) {
            if (up[color1] == m) continue;
            for (int color2 = 1; color2 <= k; color2++) {
                if (up[color2] == m || color1 == color2) continue;
                if (up[color2] >= up[color1] && down[color2] <= down[color1] &&
                        left[color2] >= left[color1] && right[color2] <= right[color1]) {
                    boolean intersect = false;
                    for (int i = up[color1]; i <= down[color1]; i++) {
                        for (int j = left[color1]; j <= right[color1]; j++) {
                            if (targetGrid[i][j] == color2) {
                                intersect = true;
                                break;
                            }
                        }
                        if (intersect) break;
                    }
                    if (intersect) {
                        adj[color1].add(color2);
                        indegree[color2]++;
                    }
                }
            }
        }

        Queue<Integer> q = new LinkedList<>();
        for (int i = 1; i <= k; i++) {
            if (up[i] != m && indegree[i] == 0) {
                q.offer(i);
            }
        }

        int count = 0;
        while (!q.isEmpty()) {
            int color = q.poll();
            count++;
            for (int neighbor : adj[color]) {
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    q.offer(neighbor);
                }
            }
        }

        for (int i = 1; i <= k; i++) {
            if (up[i] != m) {
                continue;
            }
        }

        return count == k;
    }
}