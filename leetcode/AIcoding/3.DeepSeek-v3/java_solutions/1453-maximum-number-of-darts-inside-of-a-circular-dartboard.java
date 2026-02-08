class Solution {
    public int numPoints(int[][] points, int r) {
        int n = points.length;
        int max = 1;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int[] a = points[i];
                int[] b = points[j];
                double d = Math.sqrt(Math.pow(a[0] - b[0], 2) + Math.pow(a[1] - b[1], 2));
                if (d > 2 * r) continue;
                double[] center = findCenter(a, b, r);
                int count = 0;
                for (int[] p : points) {
                    double dist = Math.sqrt(Math.pow(p[0] - center[0], 2) + Math.pow(p[1] - center[1], 2));
                    if (dist <= r + 1e-6) count++;
                }
                max = Math.max(max, count);
            }
        }
        return max;
    }

    private double[] findCenter(int[] a, int[] b, int r) {
        double x1 = a[0], y1 = a[1];
        double x2 = b[0], y2 = b[1];
        double d = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
        double h = Math.sqrt(r * r - d * d / 4);
        double mx = (x1 + x2) / 2, my = (y1 + y2) / 2;
        double dx = (y2 - y1) / d * h;
        double dy = (x1 - x2) / d * h;
        return new double[]{mx + dx, my + dy};
    }
}