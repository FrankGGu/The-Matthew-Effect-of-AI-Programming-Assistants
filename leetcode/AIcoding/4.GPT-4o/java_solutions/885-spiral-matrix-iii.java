class Solution {
    public int[][] spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        int[][] result = new int[rows * cols][2];
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int dir = 0, steps = 0, idx = 0;

        while (idx < rows * cols) {
            for (int i = 0; i < 2; i++) {
                steps = i == 0 ? (dir % 2 == 0 ? cols : rows) : (dir % 2 == 1 ? cols : rows);
                for (int j = 0; j < steps; j++) {
                    if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                        result[idx++] = new int[]{rStart, cStart};
                    }
                    rStart += directions[dir][0];
                    cStart += directions[dir][1];
                }
                dir = (dir + 1) % 4;
            }
            rows -= dir % 2 == 0 ? 1 : 0;
            cols -= dir % 2 == 1 ? 1 : 0;
        }
        return result;
    }
}