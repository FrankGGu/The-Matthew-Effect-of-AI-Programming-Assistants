class Solution {
    public boolean[] isArraySpecial(int[] nums, int[][] queries) {
        int n = nums.length;

        int[] prefixSum = new int[n];

        if (n > 1) {
            for (int i = 0; i < n - 1; i++) {
                prefixSum[i+1] = prefixSum[i] + ( (nums[i] % 2 == nums[i+1] % 2) ? 1 : 0 );
            }
        }

        int numQueries = queries.length;
        boolean[] results = new boolean[numQueries];

        for (int k = 0; k < numQueries; k++) {
            int from = queries[k][0];
            int to = queries[k][1];

            if (prefixSum[to] - prefixSum[from] == 0) {
                results[k] = true;
            } else {
                results[k] = false;
            }
        }

        return results;
    }
}