class Solution {
    public int[] maxXorSubarrayQueries(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int[] res = new int[m];

        for (int i = 0; i < m; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            int maxXor = 0;
            int currentXor = 0;

            for (int j = left; j <= right; j++) {
                currentXor ^= nums[j];
                maxXor = Math.max(maxXor, currentXor);
            }

            res[i] = maxXor;
        }

        return res;
    }
}