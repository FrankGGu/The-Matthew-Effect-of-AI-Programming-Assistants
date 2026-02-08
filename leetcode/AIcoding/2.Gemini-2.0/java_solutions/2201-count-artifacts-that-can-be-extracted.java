class Solution {
    public int digArtifacts(int n, int[][] artifacts, int[][] dig) {
        boolean[][] dug = new boolean[n][n];
        for (int[] d : dig) {
            dug[d[0]][d[1]] = true;
        }

        int count = 0;
        for (int[] artifact : artifacts) {
            boolean extracted = true;
            for (int i = artifact[0]; i <= artifact[2]; i++) {
                for (int j = artifact[1]; j <= artifact[3]; j++) {
                    if (!dug[i][j]) {
                        extracted = false;
                        break;
                    }
                }
                if (!extracted) {
                    break;
                }
            }
            if (extracted) {
                count++;
            }
        }
        return count;
    }
}