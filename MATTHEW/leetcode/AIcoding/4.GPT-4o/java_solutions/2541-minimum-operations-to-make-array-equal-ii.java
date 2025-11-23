class Solution {
    public int minOperations(int[] nums, int[] queries) {
        int n = nums.length;
        int m = queries.length;
        long[] prefix = new long[n + 1];

        Arrays.sort(nums);
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int[] result = new int[m];
        for (int i = 0; i < m; i++) {
            long x = queries[i];
            int pos = Arrays.binarySearch(nums, x);
            if (pos < 0) {
                pos = -pos - 1;
            }
            long leftSum = prefix[pos];
            long rightSum = prefix[n] - leftSum;
            long leftOps = (long) pos * x - leftSum;
            long rightOps = rightSum - (long) (n - pos) * x;
            result[i] = (int) (leftOps + rightOps);
        }

        return result;
    }
}