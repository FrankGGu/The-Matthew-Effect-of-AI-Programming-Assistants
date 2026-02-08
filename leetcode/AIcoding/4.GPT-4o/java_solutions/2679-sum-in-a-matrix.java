class MatrixSum {
    public int matrixSum(int[][] nums) {
        int rows = nums.length;
        int cols = nums[0].length;
        for (int[] row : nums) {
            Arrays.sort(row);
        }
        int total = 0;
        for (int col = 0; col < cols; col++) {
            for (int row = rows - 1; row >= 0; row--) {
                total += nums[row][col];
                break;
            }
        }
        return total;
    }
}