class Solution {
    public boolean isPrintable(int[][] targetGrid) {
        int m = targetGrid.length;
        int n = targetGrid[0].length;
        Map<Integer, int[]> colorBounds = new HashMap<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int color = targetGrid[i][j];
                if (!colorBounds.containsKey(color)) {
                    colorBounds.put(color, new int[]{i, j, i, j});
                } else {
                    int[] bounds = colorBounds.get(color);
                    bounds[0] = Math.min(bounds[0], i);
                    bounds[1] = Math.min(bounds[1], j);
                    bounds[2] = Math.max(bounds[2], i);
                    bounds[3] = Math.max(bounds[3], j);
                }
            }
        }

        Map<Integer, Set<Integer>> graph = new HashMap<>();
        int[] inDegree = new int[61];

        for (int color : colorBounds.keySet()) {
            int[] bounds = colorBounds.get(color);
            int minX = bounds[0], minY = bounds[1], maxX = bounds[2], maxY = bounds[3];
            Set<Integer> dependencies = new HashSet<>();

            for (int i = minX; i <= maxX; i++) {
                for (int j = minY; j <= maxY; j++) {
                    if (targetGrid[i][j] != color) {
                        dependencies.add(targetGrid[i][j]);
                    }
                }
            }

            graph.put(color, dependencies);
            for (int dep : dependencies) {
                inDegree[dep]++;
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int color : colorBounds.keySet()) {
            if (inDegree[color] == 0) {
                queue.offer(color);
            }
        }

        int processed = 0;
        while (!queue.isEmpty()) {
            int color = queue.poll();
            processed++;
            for (int neighbor : graph.getOrDefault(color, new HashSet<>())) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return processed == colorBounds.size();
    }
}