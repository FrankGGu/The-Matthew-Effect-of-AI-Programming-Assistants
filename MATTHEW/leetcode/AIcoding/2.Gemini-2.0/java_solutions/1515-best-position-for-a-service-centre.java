class Solution {
    public double getMinDistSum(int[][] positions) {
        double x = 0, y = 0;
        int n = positions.length;
        for (int[] p : positions) {
            x += p[0];
            y += p[1];
        }
        x /= n;
        y /= n;

        double step = 1.0;
        double eps = 1e-6;
        double minDist = Double.MAX_VALUE;

        while (step > eps) {
            double dist = getDistSum(positions, x, y);
            minDist = Math.min(minDist, dist);

            double nx = x, ny = y;
            double dx[] = {0, 0, step, -step};
            double dy[] = {step, -step, 0, 0};

            for (int i = 0; i < 4; i++) {
                double nextX = x + dx[i];
                double nextY = y + dy[i];
                double newDist = getDistSum(positions, nextX, nextY);
                if (newDist < dist) {
                    nx = nextX;
                    ny = nextY;
                    dist = newDist;
                }
            }

            if (nx == x && ny == y) {
                step /= 2.0;
            } else {
                x = nx;
                y = ny;
            }
        }

        return minDist;
    }

    private double getDistSum(int[][] positions, double x, double y) {
        double distSum = 0;
        for (int[] p : positions) {
            distSum += Math.sqrt(Math.pow(x - p[0], 2) + Math.pow(y - p[1], 2));
        }
        return distSum;
    }
}