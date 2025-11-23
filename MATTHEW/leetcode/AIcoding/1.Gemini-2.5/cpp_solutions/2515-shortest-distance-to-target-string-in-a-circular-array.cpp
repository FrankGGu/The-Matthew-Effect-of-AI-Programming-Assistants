#include <vector>
#include <string>
#include <algorithm>
#include <cmath>
#include <climits>

class Solution {
public:
    int closetTarget(std::vector<std::string>& words, std::string target, int startIndex) {
        int n = words.size();
        int ans = INT_MAX;

        for (int i = 0; i < n; ++i) {
            if (words[i] == target) {
                int dist = std::abs(i - startIndex);
                ans = std::min(ans, std::min(dist, n - dist));
            }
        }

        return ans == INT_MAX ? -1 : ans;
    }
};