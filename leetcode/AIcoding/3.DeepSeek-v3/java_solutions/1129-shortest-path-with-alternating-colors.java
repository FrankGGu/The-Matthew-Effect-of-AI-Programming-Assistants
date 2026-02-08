class Solution {
    public int[] shortestAlternatingPaths(int n, int[][] redEdges, int[][] blueEdges) {
        List<List<Integer>> redGraph = new ArrayList<>();
        List<List<Integer>> blueGraph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            redGraph.add(new ArrayList<>());
            blueGraph.add(new ArrayList<>());
        }
        for (int[] edge : redEdges) {
            redGraph.get(edge[0]).add(edge[1]);
        }
        for (int[] edge : blueEdges) {
            blueGraph.get(edge[0]).add(edge[1]);
        }

        int[][] distances = new int[n][2];
        for (int i = 0; i < n; i++) {
            distances[i][0] = -1;
            distances[i][1] = -1;
        }
        distances[0][0] = 0;
        distances[0][1] = 0;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});
        queue.offer(new int[]{0, 1});

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int node = current[0];
            int color = current[1];

            if (color == 0) {
                for (int neighbor : blueGraph.get(node)) {
                    if (distances[neighbor][1] == -1) {
                        distances[neighbor][1] = distances[node][0] + 1;
                        queue.offer(new int[]{neighbor, 1});
                    }
                }
            } else {
                for (int neighbor : redGraph.get(node)) {
                    if (distances[neighbor][0] == -1) {
                        distances[neighbor][0] = distances[node][1] + 1;
                        queue.offer(new int[]{neighbor, 0});
                    }
                }
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            if (distances[i][0] == -1 && distances[i][1] == -1) {
                result[i] = -1;
            } else if (distances[i][0] == -1) {
                result[i] = distances[i][1];
            } else if (distances[i][1] == -1) {
                result[i] = distances[i][0];
            } else {
                result[i] = Math.min(distances[i][0], distances[i][1]);
            }
        }
        return result;
    }
}