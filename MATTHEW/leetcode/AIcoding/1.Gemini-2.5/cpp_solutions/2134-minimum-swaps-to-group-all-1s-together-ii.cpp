#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minSwaps(std::vector<int>& nums) {
        int n = nums.size();
        int totalOnes = 0;
        for (int x : nums) {
            if (x == 1) {
                totalOnes++;
            }
        }

        if (totalOnes == 0 || totalOnes == n) {
            return 0;
        }

        std::vector<int> extendedNums = nums;
        extendedNums.insert(extendedNums.end(), nums.begin(), nums.end());

        int currentOnes = 0;
        for (int i = 0; i < totalOnes; ++i) {
            currentOnes += extendedNums[i];
        }

        int maxOnesInWindow = currentOnes;

        for (int i = totalOnes; i < 2 * n; ++i) {
            currentOnes += extendedNums[i] - extendedNums[i - totalOnes];
            maxOnesInWindow = std::max(maxOnesInWindow, currentOnes);
        }

        return totalOnes - maxOnesInWindow;
    }
};