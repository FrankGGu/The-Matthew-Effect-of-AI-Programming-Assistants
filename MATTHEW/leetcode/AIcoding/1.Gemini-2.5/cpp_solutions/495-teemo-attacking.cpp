#include <vector>
#include <algorithm> // Required for std::min

class Solution {
public:
    int findPoisonedDuration(std::vector<int>& timePoints, int duration) {
        if (timePoints.empty()) {
            return 0;
        }

        int totalPoisonedDuration = 0;
        int n = timePoints.size();

        for (int i = 0; i < n - 1; ++i) {
            totalPoisonedDuration += std::min(timePoints[i+1] - timePoints[i], duration);
        }

        totalPoisonedDuration += duration;

        return totalPoisonedDuration;
    }
};