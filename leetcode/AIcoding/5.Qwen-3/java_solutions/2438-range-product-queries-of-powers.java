public class Solution {
    public int[] findProductsOfSquares(int[] nums, int[][] queries) {
        int n = nums.length;
        int[] prefix = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i] * nums[i];
        }

        int m = queries.length;
        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            result[i] = prefix[r + 1] - prefix[l];
        }

        return result;
    }
}