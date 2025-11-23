#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumTime(std::vector<int>& time) {
        std::sort(time.begin(), time.end());
        int totalTime = 0;
        for (int t : time) {
            totalTime = std::max(totalTime, t) + t;
        }
        return totalTime;
    }
};