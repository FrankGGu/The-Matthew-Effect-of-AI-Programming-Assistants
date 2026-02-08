class Solution {
    public int[] longestRowWithMaxOnes(int[][] mat) {
        int maxRowIndex = -1, maxCount = 0;
        for (int i = 0; i < mat.length; i++) {
            int count = 0;
            for (int j = 0; j < mat[i].length; j++) {
                count += mat[i][j];
            }
            if (count > maxCount) {
                maxCount = count;
                maxRowIndex = i;
            }
        }
        return new int[] {maxRowIndex, maxCount};
    }
}