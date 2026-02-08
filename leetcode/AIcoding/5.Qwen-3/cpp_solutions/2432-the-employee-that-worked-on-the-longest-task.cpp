#include <iostream>
#include <vector>
#include <utility>
#include <algorithm>

class Solution {
public:
    int findLongestTask(const std::vector<std::vector<int>>& tasks) {
        int maxTime = -1;
        int resultIndex = -1;

        for (int i = 0; i < tasks.size(); ++i) {
            int startTime = tasks[i][0];
            int endTime = tasks[i][1];
            int duration = endTime - startTime;

            if (duration > maxTime) {
                maxTime = duration;
                resultIndex = i;
            }
        }

        return resultIndex;
    }
};