class Solution {
    public int smallestRotation(int[] nums) {
        int n = nums.length;
        int[] bad = new int[n];
        for (int i = 0; i < n; i++) {
            int low = (i - nums[i] + 1 + n) % n;
            bad[low]--;
            int high = (i + 1) % n;
            bad[high]++;
        }

        int bestIndex = 0;
        int maxScore = bad[0];
        int currentScore = bad[0];
        for (int i = 1; i < n; i++) {
            currentScore += bad[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                bestIndex = i;
            }
        }
        return bestIndex;
    }
}