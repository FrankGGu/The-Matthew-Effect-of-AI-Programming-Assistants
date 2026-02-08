#include <vector>
#include <algorithm>

class Solution {
public:
    int maxDistance(std::vector<int>& colors) {
        int n = colors.size();
        int max_dist = 0;

        for (int j = n - 1; j >= 0; --j) {
            if (colors[j] != colors[0]) {
                max_dist = std::max(max_dist, j);
                break;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (colors[i] != colors[n - 1]) {
                max_dist = std::max(max_dist, (n - 1) - i);
                break;
            }
        }

        return max_dist;
    }
};