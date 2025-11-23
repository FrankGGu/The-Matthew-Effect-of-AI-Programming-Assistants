#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    std::vector<int> countOfPairs(int n, int x, int y) {
        std::vector<int> ans(n, 0);

        for (int i = 1; i <= n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                int dist1 = j - i;
                int dist2 = std::abs(i - x) + std::abs(j - y) + 1;
                int dist3 = std::abs(i - y) + std::abs(j - x) + 1;

                int current_dist = std::min({dist1, dist2, dist3});

                ans[current_dist - 1]++;
            }
        }

        return ans;
    }
};