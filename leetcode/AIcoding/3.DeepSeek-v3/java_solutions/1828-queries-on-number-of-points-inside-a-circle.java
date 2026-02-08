class Solution {
    public int[] countPoints(int[][] points, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            int r = queries[i][2];
            int count = 0;
            for (int[] point : points) {
                int dx = point[0] - x;
                int dy = point[1] - y;
                if (dx * dx + dy * dy <= r * r) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}