#include <vector>
#include <numeric>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimizeTheDifference(std::vector<std::vector<int>>& mat, int target) {
        std::vector<bool> sums(target + 1, false);
        sums[0] = true;
        int min_above = INT_MAX;

        for (auto& r : mat) {
            std::sort(r.begin(), r.end());
            r.erase(std::unique(r.begin(), r.end()), r.end());
        }

        for (const auto& row : mat) {
            std::vector<bool> next_sums(target + 1, false);
            int next_min_above = INT_MAX;

            for (int s = 0; s <= target; ++s) {
                if (sums[s]) {
                    for (int val : row) {
                        int new_sum = s + val;
                        if (new_sum <= target) {
                            next_sums[new_sum] = true;
                        } else {
                            next_min_above = std::min(next_min_above, new_sum);
                        }
                    }
                }
            }

            if (min_above != INT_MAX) {
                for (int val : row) {
                    long long new_sum = (long long)min_above + val;
                    if (new_sum < INT_MAX) {
                         next_min_above = std::min(next_min_above, (int)new_sum);
                    }
                }
            }

            sums = next_sums;
            min_above = next_min_above;
        }

        int min_diff = INT_MAX;
        if (min_above != INT_MAX) {
            min_diff = std::min(min_diff, min_above - target);
        }

        for (int s = target; s >= 0; --s) {
            if (sums[s]) {
                min_diff = std::min(min_diff, target - s);
                break;
            }
        }

        return min_diff;
    }
};