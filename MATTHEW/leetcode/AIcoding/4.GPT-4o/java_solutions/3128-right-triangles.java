class Solution {
    public int countRightTriangles(int[][] points) {
        int count = 0;
        int n = points.length;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    if (isRightTriangle(points[i], points[j], points[k])) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    private boolean isRightTriangle(int[] p1, int[] p2, int[] p3) {
        int d1 = distanceSquared(p1, p2);
        int d2 = distanceSquared(p1, p3);
        int d3 = distanceSquared(p2, p3);
        return d1 + d2 == d3 || d1 + d3 == d2 || d2 + d3 == d1;
    }

    private int distanceSquared(int[] p1, int[] p2) {
        return (p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]);
    }
}