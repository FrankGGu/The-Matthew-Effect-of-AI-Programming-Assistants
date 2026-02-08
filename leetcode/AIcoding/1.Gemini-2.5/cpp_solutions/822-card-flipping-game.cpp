#include <vector>
#include <set>
#include <algorithm>
#include <limits>

class Solution {
public:
    int flipgame(std::vector<int>& fronts, std::vector<int>& backs) {
        std::set<int> forbidden_numbers;
        int n = fronts.size();

        for (int i = 0; i < n; ++i) {
            if (fronts[i] == backs[i]) {
                forbidden_numbers.insert(fronts[i]);
            }
        }

        int min_good_number = std::numeric_limits<int>::max();

        for (int i = 0; i < n; ++i) {
            if (forbidden_numbers.find(fronts[i]) == forbidden_numbers.end()) {
                min_good_number = std::min(min_good_number, fronts[i]);
            }
            if (forbidden_numbers.find(backs[i]) == forbidden_numbers.end()) {
                min_good_number = std::min(min_good_number, backs[i]);
            }
        }

        if (min_good_number == std::numeric_limits<int>::max()) {
            return 0;
        } else {
            return min_good_number;
        }
    }
};