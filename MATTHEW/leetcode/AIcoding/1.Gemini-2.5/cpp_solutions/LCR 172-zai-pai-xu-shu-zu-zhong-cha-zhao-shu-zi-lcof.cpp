#include <vector>
#include <algorithm>
#include <iterator>

class Solution {
public:
    int countTarget(std::vector<int>& scores, int target) {
        auto lower = std::lower_bound(scores.begin(), scores.end(), target);
        auto upper = std::upper_bound(scores.begin(), scores.end(), target);
        return std::distance(lower, upper);
    }
};