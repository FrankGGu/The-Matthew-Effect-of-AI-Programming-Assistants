class Solution {
    public int[][] createNewColumn(int[][] data) {
        if (data == null || data.length == 0) {
            return new int[0][0];
        }

        int numRows = data.length;
        int numCols = data[0].length;

        int[][] result = new int[numRows][numCols + 1];

        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
                result[i][j] = data[i][j];
            }
            result[i][numCols] = 0; 
        }
        return result;
    }
}