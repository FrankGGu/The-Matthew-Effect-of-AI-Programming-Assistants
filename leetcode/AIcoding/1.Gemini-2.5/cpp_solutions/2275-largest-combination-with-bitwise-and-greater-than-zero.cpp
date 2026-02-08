class Solution {
public:
    int largestCombination(std::vector<int>& candidates) {
        int maxCombinationSize = 0;
        for (int i = 0; i < 31; ++i) { // Iterate through bit positions from 0 to 30
            int currentBitCount = 0;
            for (int num : candidates) {
                if ((num >> i) & 1) { // Check if the i-th bit is set in the current number
                    currentBitCount++;
                }
            }
            if (currentBitCount > maxCombinationSize) {
                maxCombinationSize = currentBitCount;
            }
        }
        return maxCombinationSize;
    }
};