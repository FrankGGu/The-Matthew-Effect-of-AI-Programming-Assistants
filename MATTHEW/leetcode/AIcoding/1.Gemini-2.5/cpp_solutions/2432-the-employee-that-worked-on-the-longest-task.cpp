#include <vector>
#include <algorithm>

class Solution {
public:
    int hardestWorker(int n, std::vector<std::vector<int>>& logs) {
        int maxDuration = 0;
        int hardestWorkerId = -1;
        int previousEndTime = 0;

        for (const auto& log : logs) {
            int currentId = log[0];
            int currentEndTime = log[1];
            int currentDuration = currentEndTime - previousEndTime;

            if (currentDuration > maxDuration) {
                maxDuration = currentDuration;
                hardestWorkerId = currentId;
            } else if (currentDuration == maxDuration) {
                hardestWorkerId = std::min(hardestWorkerId, currentId);
            }
            previousEndTime = currentEndTime;
        }

        return hardestWorkerId;
    }
};