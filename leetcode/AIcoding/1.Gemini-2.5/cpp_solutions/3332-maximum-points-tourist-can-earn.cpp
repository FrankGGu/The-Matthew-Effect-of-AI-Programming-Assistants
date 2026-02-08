#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int maxScoreSightseeingPair(std::vector<int>& values) {
        int n = values.size();
        int max_score = std::numeric_limits<int>::min();
        int max_val_plus_i = values[0] + 0;

        for (int j = 1; j < n; ++j) {
            max_score = std::max(max_score, max_val_plus_i + (values[j] - j));
            max_val_plus_i = std::max(max_val_plus_i, values[j] + j);
        }

        return max_score;
    }
};