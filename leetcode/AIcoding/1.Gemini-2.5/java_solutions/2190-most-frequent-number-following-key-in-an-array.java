class Solution {
    public int mostFrequent(int[] nums, int key) {
        int[] targetFreq = new int[1001]; 

        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == key) {
                int target = nums[i+1];
                targetFreq[target]++;
            }
        }

        int maxFreq = 0;
        int mostFrequentTarget = -1; 

        for (int targetVal = 1; targetVal <= 1000; targetVal++) {
            if (targetFreq[targetVal] > maxFreq) {
                maxFreq = targetFreq[targetVal];
                mostFrequentTarget = targetVal;
            }
        }

        return mostFrequentTarget;
    }
}