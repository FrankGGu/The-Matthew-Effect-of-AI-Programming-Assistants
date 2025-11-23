class Solution {
    public int countSubsequencesWithUniqueMode(int[] nums) {
        int n = nums.length;
        int total = 0;
        for (int i = 0; i < n; i++) {
            int[] freq = new int[101];
            int maxFreq = 0;
            int modeCount = 0;
            for (int j = i; j < n; j++) {
                int num = nums[j];
                freq[num]++;
                if (freq[num] > maxFreq) {
                    maxFreq = freq[num];
                    modeCount = 1;
                } else if (freq[num] == maxFreq) {
                    modeCount++;
                }
                if (modeCount == 1) {
                    total++;
                }
            }
        }
        return total;
    }
}