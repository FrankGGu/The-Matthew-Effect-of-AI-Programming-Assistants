class Solution {
    public int[] countPoints(int[][] points, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int count = 0;
            for (int j = 0; j < points.length; j++) {
                int x = points[j][0];
                int y = points[j][1];
                int centerX = queries[i][0];
                int centerY = queries[i][1];
                int radius = queries[i][2];
                if (Math.pow(x - centerX, 2) + Math.pow(y - centerY, 2) <= Math.pow(radius, 2)) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}