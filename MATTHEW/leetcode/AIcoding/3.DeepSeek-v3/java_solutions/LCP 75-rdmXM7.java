class Solution {
    public int[] shortestAlternatingPaths(int n, int[][] redEdges, int[][] blueEdges) {
        List<Integer>[][] graph = new List[2][n];
        for (int i = 0; i < n; i++) {
            graph[0][i] = new ArrayList<>();
            graph[1][i] = new ArrayList<>();
        }
        for (int[] edge : redEdges) {
            graph[0][edge[0]].add(edge[1]);
        }
        for (int[] edge : blueEdges) {
            graph[1][edge[0]].add(edge[1]);
        }

        int[][] dist = new int[2][n];
        Arrays.fill(dist[0], Integer.MAX_VALUE);
        Arrays.fill(dist[1], Integer.MAX_VALUE);
        dist[0][0] = 0;
        dist[1][0] = 0;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});
        queue.offer(new int[]{0, 1});

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int node = curr[0];
            int color = curr[1];
            for (int neighbor : graph[1 - color][node]) {
                if (dist[1 - color][neighbor] == Integer.MAX_VALUE) {
                    dist[1 - color][neighbor] = dist[color][node] + 1;
                    queue.offer(new int[]{neighbor, 1 - color});
                }
            }
        }

        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            int minDist = Math.min(dist[0][i], dist[1][i]);
            res[i] = minDist == Integer.MAX_VALUE ? -1 : minDist;
        }
        return res;
    }
}