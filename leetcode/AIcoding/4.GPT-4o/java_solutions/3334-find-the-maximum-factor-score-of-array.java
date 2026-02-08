class Solution {
    public int maxFactorScore(int[] nums) {
        int n = nums.length;
        int maxScore = 0;

        for (int i = 0; i < n; i++) {
            int score = nums[i];
            for (int j = 0; j < n; j++) {
                if (i != j && nums[i] % nums[j] == 0) {
                    score += nums[j];
                }
            }
            maxScore = Math.max(maxScore, score);
        }

        return maxScore;
    }
}