class Solution {
    public int[][] spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        int[][] result = new int[rows * cols][2];
        int[][] directions = new int[][]{{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int direction = 0;
        int step = 1;
        int count = 0;
        result[count++] = new int[]{rStart, cStart};

        while (count < rows * cols) {
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < step; j++) {
                    rStart += directions[direction][0];
                    cStart += directions[direction][1];
                    if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                        result[count++] = new int[]{rStart, cStart};
                        if (count == rows * cols) {
                            return result;
                        }
                    }
                }
                direction = (direction + 1) % 4;
            }
            step++;
        }
        return result;
    }
}