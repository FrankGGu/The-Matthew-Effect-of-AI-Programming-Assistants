class Solution {
    public int countLatticePoints(int[][] circles) {
        Set<String> points = new HashSet<>();
        for (int[] circle : circles) {
            int x = circle[0], y = circle[1], r = circle[2];
            for (int i = x - r; i <= x + r; i++) {
                for (int j = y - r; j <= y + r; j++) {
                    if ((i - x) * (i - x) + (j - y) * (j - y) <= r * r) {
                        points.add(i + "," + j);
                    }
                }
            }
        }
        return points.size();
    }
}