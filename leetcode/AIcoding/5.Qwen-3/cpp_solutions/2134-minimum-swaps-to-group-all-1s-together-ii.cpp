#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minSwaps(vector<int>& nums) {
        int n = nums.size();
        int totalOnes = 0;
        for (int num : nums) {
            totalOnes += num;
        }
        if (totalOnes == 0 || totalOnes == n) {
            return 0;
        }
        int windowSize = totalOnes;
        int maxOnesInWindow = 0;
        int currentOnes = 0;
        for (int i = 0; i < windowSize; ++i) {
            currentOnes += nums[i];
        }
        maxOnesInWindow = currentOnes;
        for (int i = windowSize; i < n; ++i) {
            currentOnes += nums[i] - nums[i - windowSize];
            maxOnesInWindow = max(maxOnesInWindow, currentOnes);
        }
        return windowSize - maxOnesInWindow;
    }
};