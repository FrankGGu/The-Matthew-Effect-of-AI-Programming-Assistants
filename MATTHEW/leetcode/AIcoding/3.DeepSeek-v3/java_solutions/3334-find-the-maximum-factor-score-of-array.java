class Solution {
    public long maxScore(int[] nums) {
        int n = nums.length;
        long maxScore = 0;
        long sum = 0;
        Arrays.sort(nums);
        for (int i = n - 1; i >= 0; i--) {
            sum += nums[i];
            if (nums[i] > 0) {
                maxScore = Math.max(maxScore, sum * (n - i));
            }
        }
        return maxScore;
    }
}