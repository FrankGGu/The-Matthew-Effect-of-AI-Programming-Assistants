#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxSatisfaction(std::vector<int>& satisfaction) {
        std::sort(satisfaction.begin(), satisfaction.end());

        int max_like_time_coefficient = 0;
        int current_like_time_coefficient = 0;
        int current_suffix_sum = 0;

        for (int i = satisfaction.size() - 1; i >= 0; --i) {
            int s = satisfaction[i];

            // If we include the current dish 's' and all dishes to its right (which are already considered)
            // 's' gets time 1. All previously considered dishes get their time coefficient incremented by 1.
            // So, new_like_time_coefficient = s * 1 + (old_like_time_coefficient + sum_of_previously_considered_dishes)
            current_like_time_coefficient = current_like_time_coefficient + current_suffix_sum + s;
            current_suffix_sum = current_suffix_sum + s;

            max_like_time_coefficient = std::max(max_like_time_coefficient, current_like_time_coefficient);
        }

        return max_like_time_coefficient;
    }
};