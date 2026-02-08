class Solution {
    public int countSubmatrices(int[][] matrix, int k) {
        int m = matrix.length;
        int n = matrix[0].length;
        int count = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int sum = 0;
                for (int row = i; row < m; row++) {
                    for (int col = j; col < n; col++) {
                        sum += matrix[row][col];
                        if (sum <= k) {
                            count++;
                        } else {
                            break;
                        }
                    }
                }
            }
        }

        return count;
    }
}