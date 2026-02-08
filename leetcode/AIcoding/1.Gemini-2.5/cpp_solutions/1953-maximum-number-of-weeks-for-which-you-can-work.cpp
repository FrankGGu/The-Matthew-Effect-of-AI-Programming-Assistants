#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long numberOfWeeks(std::vector<int>& milestones) {
        long long total_sum = 0;
        long long max_val = 0;

        for (int milestone : milestones) {
            total_sum += milestone;
            if (milestone > max_val) {
                max_val = milestone;
            }
        }

        long long other_tasks_sum = total_sum - max_val;

        if (max_val <= other_tasks_sum + 1) {
            return total_sum;
        } else {
            return other_tasks_sum * 2 + 1;
        }
    }
};