#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxSatisfied(std::vector<int>& customers, std::vector<int>& grumpy, int minutes) {
        int n = customers.size();
        int base_satisfied = 0;

        for (int i = 0; i < n; ++i) {
            if (grumpy[i] == 0) {
                base_satisfied += customers[i];
            }
        }

        int current_window_additional_satisfied = 0;
        int max_additional_satisfied = 0;

        for (int i = 0; i < minutes; ++i) {
            if (grumpy[i] == 1) {
                current_window_additional_satisfied += customers[i];
            }
        }
        max_additional_satisfied = current_window_additional_satisfied;

        for (int i = minutes; i < n; ++i) {
            if (grumpy[i] == 1) {
                current_window_additional_satisfied += customers[i];
            }
            if (grumpy[i - minutes] == 1) {
                current_window_additional_satisfied -= customers[i - minutes];
            }
            max_additional_satisfied = std::max(max_additional_satisfied, current_window_additional_satisfied);
        }

        return base_satisfied + max_additional_satisfied;
    }
};