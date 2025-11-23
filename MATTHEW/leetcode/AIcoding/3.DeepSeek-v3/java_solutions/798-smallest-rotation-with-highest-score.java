class Solution {
    public int bestRotation(int[] nums) {
        int n = nums.length;
        int[] change = new int[n + 1];
        for (int i = 0; i < n; i++) {
            int left = (i - nums[i] + 1 + n) % n;
            int right = (i + 1) % n;
            change[left]--;
            change[right]++;
            if (left > right) {
                change[0]--;
            }
        }
        int bestRotation = 0;
        int maxScore = 0;
        int currentScore = 0;
        for (int i = 0; i < n; i++) {
            currentScore += change[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                bestRotation = i;
            }
        }
        return bestRotation;
    }
}