#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> longestObstacleCourseAtEachPosition(std::vector<int>& obstacles) {
        int n = obstacles.size();
        std::vector<int> ans(n);
        std::vector<int> lis;

        for (int i = 0; i < n; ++i) {
            int current_obstacle = obstacles[i];

            auto it = std::upper_bound(lis.begin(), lis.end(), current_obstacle);
            int pos = it - lis.begin();

            ans[i] = pos + 1;

            if (pos == lis.size()) {
                lis.push_back(current_obstacle);
            } else {
                lis[pos] = current_obstacle;
            }
        }

        return ans;
    }
};