class Solution {
    public int minOperations(int[] nums, int k) {
        if (k == 1) return 0;
        int n = nums.length;
        long sum = 0;
        for (int num : nums) {
            sum = (sum + num) % k;
        }
        if (sum == 0) return 0;

        int ans = n;
        for (int i = 0; i < n; ++i) {
            long currSum = 0;
            for (int j = i; j < n; ++j) {
                currSum = (currSum + nums[j]) % k;
                if ((sum - currSum + k) % k == 0) {
                    ans = Math.min(ans, j - i + 1);
                }
            }
        }

        return ans == n ? -1 : ans;
    }
}