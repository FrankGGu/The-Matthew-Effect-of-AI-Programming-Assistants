class Solution {
    public int canBeExtracted(int n, int[][] artifacts, int[][] dig) {
        boolean[][] dugGrid = new boolean[n][n];
        for (int[] d : dig) {
            dugGrid[d[0]][d[1]] = true;
        }

        int extractedCount = 0;
        for (int[] artifact : artifacts) {
            int r1 = artifact[0];
            int c1 = artifact[1];
            int r2 = artifact[2];
            int c2 = artifact[3];

            boolean canExtract = true;
            for (int r = r1; r <= r2; r++) {
                for (int c = c1; c <= c2; c++) {
                    if (!dugGrid[r][c]) {
                        canExtract = false;
                        break;
                    }
                }
                if (!canExtract) {
                    break;
                }
            }

            if (canExtract) {
                extractedCount++;
            }
        }
        return extractedCount;
    }
}