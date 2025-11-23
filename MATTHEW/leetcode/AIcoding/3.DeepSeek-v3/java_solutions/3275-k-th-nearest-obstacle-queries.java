class Solution {
    public int[] kthNearestObstacle(int[] obstacles, int[][] queries) {
        int n = obstacles.length;
        int m = queries.length;
        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int x = queries[i][0];
            int k = queries[i][1];
            List<Integer> distances = new ArrayList<>();

            for (int j = 0; j < n; j++) {
                if (obstacles[j] == 1) {
                    distances.add(Math.abs(j - x));
                }
            }

            Collections.sort(distances);
            if (k <= distances.size()) {
                result[i] = distances.get(k - 1);
            } else {
                result[i] = -1;
            }
        }

        return result;
    }
}