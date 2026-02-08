class Solution {
    public int countLatticePoints(int[][] circles) {
        int count = 0;
        boolean[][] visited = new boolean[201][201];

        for (int[] circle : circles) {
            int x = circle[0];
            int y = circle[1];
            int r = circle[2];

            for (int i = x - r; i <= x + r; i++) {
                for (int j = y - r; j <= y + r; j++) {
                    if (i >= 0 && i <= 200 && j >= 0 && j <= 200) {
                        if ((i - x) * (i - x) + (j - y) * (j - y) <= r * r) {
                            if (!visited[i][j]) {
                                count++;
                                visited[i][j] = true;
                            }
                        }
                    }
                }
            }
        }

        return count;
    }
}