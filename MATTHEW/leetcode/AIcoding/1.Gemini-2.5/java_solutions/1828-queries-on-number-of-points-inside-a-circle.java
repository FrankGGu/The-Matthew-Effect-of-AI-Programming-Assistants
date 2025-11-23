class Solution {
    public int[] countPoints(int[][] points, int[][] queries) {
        int[] result = new int[queries.length];

        for (int j = 0; j < queries.length; j++) {
            int cx = queries[j][0];
            int cy = queries[j][1];
            int r = queries[j][2];
            int rSquared = r * r;
            int count = 0;

            for (int i = 0; i < points.length; i++) {
                int px = points[i][0];
                int py = points[i][1];

                int dx = px - cx;
                int dy = py - cy;

                int distSquared = dx * dx + dy * dy;

                if (distSquared <= rSquared) {
                    count++;
                }
            }
            result[j] = count;
        }

        return result;
    }
}