class Solution {
    public long minimumOperations(int[] nums) {
        long ans = 0;
        long currentDecrement = 0;
        for (int i = 0; i < nums.length; i++) {
            long effectiveValue = nums[i] - currentDecrement;
            if (effectiveValue > 0) {
                ans += effectiveValue;
                currentDecrement += effectiveValue;
            }
        }
        return ans;
    }
}