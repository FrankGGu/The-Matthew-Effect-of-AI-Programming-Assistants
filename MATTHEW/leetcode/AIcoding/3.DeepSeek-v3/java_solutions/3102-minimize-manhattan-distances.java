class Solution {
    public int minManhattanDistance(int[][] points) {
        int n = points.length;
        int[] x = new int[n];
        int[] y = new int[n];
        for (int i = 0; i < n; i++) {
            x[i] = points[i][0] + points[i][1];
            y[i] = points[i][0] - points[i][1];
        }
        Arrays.sort(x);
        Arrays.sort(y);
        int minX = x[n / 2];
        int minY = y[n / 2];
        int sum = 0;
        for (int i = 0; i < n; i++) {
            sum += Math.abs(x[i] - minX) + Math.abs(y[i] - minY);
        }
        return sum / 2;
    }
}