#include <vector>
#include <algorithm>

class Solution {
public:
    int maxSatisfaction(std::vector<int>& satisfaction) {
        std::sort(satisfaction.begin(), satisfaction.end());

        int maxOverallSatisfaction = 0;
        int currentSumOfSatisfactions = 0;
        int currentLikeTimeCoefficient = 0;

        for (int i = satisfaction.size() - 1; i >= 0; --i) {
            currentSumOfSatisfactions += satisfaction[i];
            currentLikeTimeCoefficient += currentSumOfSatisfactions;
            maxOverallSatisfaction = std::max(maxOverallSatisfaction, currentLikeTimeCoefficient);
        }

        return maxOverallSatisfaction;
    }
};