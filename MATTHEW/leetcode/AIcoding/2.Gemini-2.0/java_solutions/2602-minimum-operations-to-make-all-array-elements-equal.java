class Solution {
    public int minOperations(int[] nums, int[] queries) {
        Arrays.sort(nums);
        int n = nums.length;
        int m = queries.length;
        int[] ans = new int[m];
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = 0; i < m; i++) {
            int query = queries[i];
            int left = 0;
            int right = n - 1;
            int index = n;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (nums[mid] >= query) {
                    index = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            long leftSum = (long)query * index - prefixSum[index];
            long rightSum = prefixSum[n] - prefixSum[index] - (long)query * (n - index);
            ans[i] = (int)(leftSum + rightSum);
        }
        return ans;
    }
}