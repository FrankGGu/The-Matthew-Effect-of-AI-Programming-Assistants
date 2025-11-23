class Solution {
    public int[] countPoints(int[][] points, int[][] queries) {
        int n = queries.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int[] query = queries[i];
            int count = 0;
            int xq = query[0], yq = query[1], r = query[2];
            for (int[] point : points) {
                int xp = point[0], yp = point[1];
                if ((xp - xq) * (xp - xq) + (yp - yq) * (yp - yq) <= r * r) {
                    count++;
                }
            }
            result[i] = count;
        }

        return result;
    }
}