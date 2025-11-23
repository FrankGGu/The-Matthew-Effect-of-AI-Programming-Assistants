#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> longestObstacleCourseAtEachPosition(std::vector<int>& obstacles) {
        int n = obstacles.size();
        std::vector<int> ans(n);
        std::vector<int> tails; // Stores the smallest ending element of a non-decreasing subsequence of a given length

        for (int i = 0; i < n; ++i) {
            int obstacle = obstacles[i];

            auto it = std::upper_bound(tails.begin(), tails.end(), obstacle);

            if (it == tails.end()) {
                tails.push_back(obstacle);
                ans[i] = tails.size();
            } else {
                *it = obstacle;
                ans[i] = std::distance(tails.begin(), it) + 1;
            }
        }

        return ans;
    }
};