#include <vector>
#include <set>
#include <algorithm>
#include <climits>

class Solution {
public:
    int closestToTarget(std::vector<int>& arr, int target) {
        int min_diff = INT_MAX;
        std::set<int> current_and_values;

        for (int x : arr) {
            std::set<int> next_and_values;
            next_and_values.insert(x); 

            for (int val : current_and_values) {
                next_and_values.insert(val & x);
            }

            current_and_values = next_and_values;

            for (int val : current_and_values) {
                min_diff = std::min(min_diff, std::abs(val - target));
            }
        }

        return min_diff;
    }
};