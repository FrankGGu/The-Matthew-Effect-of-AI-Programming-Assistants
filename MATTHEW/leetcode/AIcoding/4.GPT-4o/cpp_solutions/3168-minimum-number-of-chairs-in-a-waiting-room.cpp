#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumNumberOfChairs(std::vector<std::vector<int>>& times) {
        std::vector<int> start, end;
        for (const auto& time : times) {
            start.push_back(time[0]);
            end.push_back(time[1]);
        }
        std::sort(start.begin(), start.end());
        std::sort(end.begin(), end.end());

        int chairs = 0, endIndex = 0;
        for (int i = 0; i < start.size(); ++i) {
            if (start[i] < end[endIndex]) {
                chairs++;
            } else {
                endIndex++;
            }
        }
        return chairs;
    }
};