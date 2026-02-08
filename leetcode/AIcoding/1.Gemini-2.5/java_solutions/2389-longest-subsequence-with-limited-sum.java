import java.util.Arrays;

class Solution {
    public int[] answerQueries(int[] nums, int[] queries) {
        Arrays.sort(nums);

        int n = nums.length;
        int[] prefixSum = new int[n];
        if (n > 0) {
            prefixSum[0] = nums[0];
            for (int i = 1; i < n; i++) {
                prefixSum[i] = prefixSum[i - 1] + nums[i];
            }
        }

        int qLen = queries.length;
        int[] ans = new int[qLen];

        for (int i = 0; i < qLen; i++) {
            int query = queries[i];

            int idx = Arrays.binarySearch(prefixSum, query);

            if (idx >= 0) {
                ans[i] = idx + 1;
            } else {
                ans[i] = -idx - 1;
            }
        }

        return ans;
    }
}