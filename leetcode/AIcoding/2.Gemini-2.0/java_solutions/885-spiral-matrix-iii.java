class Solution {
    public int[][] spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        int[][] result = new int[rows * cols][2];
        int index = 0;
        int step = 1;
        result[index++] = new int[]{rStart, cStart};
        if (index == rows * cols) return result;

        while (index < rows * cols) {
            // Move right
            for (int i = 0; i < step; i++) {
                cStart++;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    result[index++] = new int[]{rStart, cStart};
                }
                if (index == rows * cols) return result;
            }

            // Move down
            for (int i = 0; i < step; i++) {
                rStart++;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    result[index++] = new int[]{rStart, cStart};
                }
                if (index == rows * cols) return result;
            }

            step++;

            // Move left
            for (int i = 0; i < step; i++) {
                cStart--;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    result[index++] = new int[]{rStart, cStart};
                }
                if (index == rows * cols) return result;
            }

            // Move up
            for (int i = 0; i < step; i++) {
                rStart--;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    result[index++] = new int[]{rStart, cStart};
                }
                if (index == rows * cols) return result;
            }

            step++;
        }

        return result;
    }
}