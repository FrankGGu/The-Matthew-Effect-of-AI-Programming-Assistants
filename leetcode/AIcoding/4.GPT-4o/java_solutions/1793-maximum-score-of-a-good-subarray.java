class Solution {
    public int maximumScore(int[] nums, int k) {
        int n = nums.length;
        int maxScore = 0;

        for (int i = k; i < n; i++) {
            int minValue = nums[i];
            for (int j = i; j >= k; j--) {
                minValue = Math.min(minValue, nums[j]);
                maxScore = Math.max(maxScore, minValue * (i - j + 1));
            }
        }

        return maxScore;
    }
}