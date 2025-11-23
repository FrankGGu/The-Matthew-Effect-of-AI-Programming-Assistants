class Solution {
    public List<Integer> luckyNumbers (int[][] matrix) {
        List<Integer> luckyNumbers = new ArrayList<>();
        int rows = matrix.length;
        int cols = matrix[0].length;

        for (int i = 0; i < rows; i++) {
            int minRow = matrix[i][0];
            for (int j = 1; j < cols; j++) {
                minRow = Math.min(minRow, matrix[i][j]);
            }
            boolean isLucky = true;
            for (int k = 0; k < rows; k++) {
                if (matrix[k][j] > minRow) {
                    isLucky = false;
                    break;
                }
            }
            if (isLucky) {
                luckyNumbers.add(minRow);
            }
        }
        return luckyNumbers;
    }
}