class Solution {
    public int[] rowAndMaximumOnes(int[][] mat) {
        int maxOnes = -1;
        int maxRowIndex = -1;

        for (int i = 0; i < mat.length; i++) {
            int currentOnes = 0;
            for (int j = 0; j < mat[i].length; j++) {
                if (mat[i][j] == 1) {
                    currentOnes++;
                }
            }

            if (currentOnes > maxOnes) {
                maxOnes = currentOnes;
                maxRowIndex = i;
            }
        }

        return new int[]{maxRowIndex, maxOnes};
    }
}