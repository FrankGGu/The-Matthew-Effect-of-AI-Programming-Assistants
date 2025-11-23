class Solution {
    public long[] findPrefixScore(int[] nums) {
        int n = nums.length;
        long[] ans = new long[n];
        long currentMax = 0;
        long currentPrefixScoreSum = 0;

        for (int i = 0; i < n; i++) {
            currentMax = Math.max(currentMax, nums[i]);
            long elementScore = nums[i] + currentMax;
            currentPrefixScoreSum += elementScore;
            ans[i] = currentPrefixScoreSum;
        }

        return ans;
    }
}