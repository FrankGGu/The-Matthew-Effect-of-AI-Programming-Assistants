#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int maxDistance(std::vector<std::vector<int>>& arrays) {
        int max_dist = 0;

        int min_so_far = arrays[0][0];
        int max_so_far = arrays[0].back();

        for (size_t i = 1; i < arrays.size(); ++i) {
            max_dist = std::max(max_dist, std::abs(arrays[i].back() - min_so_far));
            max_dist = std::max(max_dist, std::abs(arrays[i][0] - max_so_far));

            min_so_far = std::min(min_so_far, arrays[i][0]);
            max_so_far = std::max(max_so_far, arrays[i].back());
        }

        return max_dist;
    }
};