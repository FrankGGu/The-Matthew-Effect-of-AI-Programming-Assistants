class Solution {
    public int sumOfVariableLengthSubarrays(int[] nums, int k) {
        int n = nums.length;
        int ans = 0;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n; j++) {
                sum += nums[j];
                if ((j - i + 1) >= k) {
                    ans += sum;
                }
            }
        }
        return ans;
    }
}