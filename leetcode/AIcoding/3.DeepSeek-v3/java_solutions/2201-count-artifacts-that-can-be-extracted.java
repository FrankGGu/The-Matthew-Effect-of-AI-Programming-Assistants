class Solution {
    public int digArtifacts(int n, int[][] artifacts, int[][] dig) {
        boolean[][] dug = new boolean[n][n];
        for (int[] d : dig) {
            dug[d[0]][d[1]] = true;
        }

        int count = 0;
        for (int[] artifact : artifacts) {
            int r1 = artifact[0], c1 = artifact[1], r2 = artifact[2], c2 = artifact[3];
            boolean canExtract = true;
            for (int i = r1; i <= r2; i++) {
                for (int j = c1; j <= c2; j++) {
                    if (!dug[i][j]) {
                        canExtract = false;
                        break;
                    }
                }
                if (!canExtract) {
                    break;
                }
            }
            if (canExtract) {
                count++;
            }
        }
        return count;
    }
}