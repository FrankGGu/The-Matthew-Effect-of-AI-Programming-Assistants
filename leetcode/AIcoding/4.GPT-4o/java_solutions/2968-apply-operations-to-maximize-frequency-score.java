class Solution {
    public int maximizeFrequencyScore(int[] nums, int k) {
        int n = nums.length;
        int[] count = new int[100001];
        for (int num : nums) {
            count[num]++;
        }

        int maxFrequencyScore = 0;
        for (int num = 1; num < count.length; num++) {
            if (count[num] > 0) {
                int currentScore = count[num];
                int operations = k;
                for (int j = 1; j <= count[num]; j++) {
                    if (operations <= 0) break;
                    if (j < count[num] && operations > 0) {
                        int needed = (num + j) - num;
                        if (needed <= operations) {
                            operations -= needed;
                            currentScore++;
                        }
                    }
                }
                maxFrequencyScore = Math.max(maxFrequencyScore, currentScore);
            }
        }

        return maxFrequencyScore;
    }
}