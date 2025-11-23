#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int distributeCookies(std::vector<int>& cookies, int k) {
        int n = cookies.size();
        std::vector<int> distribution(k, 0);
        return backtrack(cookies, distribution, 0, k, INT_MAX);
    }

private:
    int backtrack(std::vector<int>& cookies, std::vector<int>& distribution, int index, int k, int minMax) {
        if (index == cookies.size()) {
            return *std::max_element(distribution.begin(), distribution.end());
        }

        for (int i = 0; i < k; ++i) {
            distribution[i] += cookies[index];
            if (distribution[i] <= minMax) {
                minMax = std::min(minMax, backtrack(cookies, distribution, index + 1, k, minMax));
            }
            distribution[i] -= cookies[index];
            if (distribution[i] == 0) break; // optimization
        }

        return minMax;
    }
};