class Solution {
    public int numSubmatrixSumTarget(int[][] matrix, int target) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] prefixSum = new int[m + 1][n + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + matrix[i - 1][j - 1];
            }
        }

        int count = 0;
        for (int r1 = 1; r1 <= m; r1++) {
            for (int r2 = r1; r2 <= m; r2++) {
                Map<Integer, Integer> map = new HashMap<>();
                map.put(0, 1);
                for (int c = 1; c <= n; c++) {
                    int currentSum = prefixSum[r2][c] - prefixSum[r1 - 1][c];
                    count += map.getOrDefault(currentSum - target, 0);
                    map.put(currentSum, map.getOrDefault(currentSum, 0) + 1);
                }
            }
        }
        return count;
    }
}