class Solution {
    public double getMinDistSum(int[][] positions) {
        double currentX = 0.0;
        double currentY = 0.0;

        for (int[] p : positions) {
            currentX += p[0];
            currentY += p[1];
        }
        currentX /= positions.length;
        currentY /= positions.length;

        double step = 100.0;
        double epsilon = 1e-7;

        double[][] directions = {
            {0, 1}, {0, -1}, {1, 0}, {-1, 0}
        };

        while (step > epsilon) {
            double bestX = currentX;
            double bestY = currentY;
            double minSum = calculateDistanceSum(currentX, currentY, positions);

            for (double[] dir : directions) {
                double nextX = currentX + dir[0] * step;
                double nextY = currentY + dir[1] * step;

                double newSum = calculateDistanceSum(nextX, nextY, positions);

                if (newSum < minSum) {
                    minSum = newSum;
                    bestX = nextX;
                    bestY = nextY;
                }
            }

            if (bestX == currentX && bestY == currentY) {
                step /= 2.0;
            } else {
                currentX = bestX;
                currentY = bestY;
            }
        }

        return minSum;
    }

    private double calculateDistanceSum(double x, double y, int[][] positions) {
        double sum = 0.0;
        for (int[] p : positions) {
            double dx = x - p[0];
            double dy = y - p[1];
            sum += Math.sqrt(dx * dx + dy * dy);
        }
        return sum;
    }
}