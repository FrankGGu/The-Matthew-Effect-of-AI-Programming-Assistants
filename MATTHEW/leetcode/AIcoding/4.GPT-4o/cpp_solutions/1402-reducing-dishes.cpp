#include <vector>
#include <algorithm>

class Solution {
public:
    int maxSatisfaction(std::vector<int>& satisfaction) {
        std::sort(satisfaction.begin(), satisfaction.end());
        int maxSum = 0, currentSum = 0, total = 0;
        for (int i = satisfaction.size() - 1; i >= 0; --i) {
            currentSum += satisfaction[i];
            total += currentSum;
            maxSum = std::max(maxSum, total);
        }
        return maxSum;
    }
};