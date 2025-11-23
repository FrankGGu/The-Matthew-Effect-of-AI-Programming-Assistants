class Solution {
    public int largestCombination(int[] candidates) {
        int maxCombinationSize = 0;

        for (int i = 0; i < 31; i++) { // Iterate through each bit position from 0 to 30
            int currentBitSetCount = 0;
            int mask = 1 << i; // Create a mask for the current bit position

            for (int num : candidates) {
                if ((num & mask) != 0) { // Check if the i-th bit is set in the current number
                    currentBitSetCount++;
                }
            }
            maxCombinationSize = Math.max(maxCombinationSize, currentBitSetCount);
        }

        return maxCombinationSize;
    }
}