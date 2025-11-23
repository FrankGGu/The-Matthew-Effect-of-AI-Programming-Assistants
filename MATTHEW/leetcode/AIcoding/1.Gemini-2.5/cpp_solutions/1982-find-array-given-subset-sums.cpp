#include <vector>
#include <numeric>
#include <algorithm>
#include <set> // For std::multiset

class Solution {
public:
    std::vector<int> findArray(std::vector<int>& sums_int, int n) {
        std::multiset<long long> current_sums_ms;
        for (int sum_val : sums_int) {
            current_sums_ms.insert(sum_val);
        }

        std::vector<long long> ans_long_long;
        long long current_target_zero = 0;

        for (int i = 0; i < n; ++i) {
            long long x = *std::next(current_sums_ms.begin()) - *current_sums_ms.begin();

            std::vector<long long> next_level_sums_candidate;
            std::multiset<long long> temp_ms = current_sums_ms;

            for (long long val : current_sums_ms) {
                if (temp_ms.count(val) > 0) {
                    temp_ms.erase(temp_ms.find(val));
                    temp_ms.erase(temp_ms.find(val + x));
                    next_level_sums_candidate.push_back(val);
                }
            }

            bool target_zero_found = false;
            for (long long s : next_level_sums_candidate) {
                if (s == current_target_zero) {
                    target_zero_found = true;
                    break;
                }
            }

            if (target_zero_found) {
                ans_long_long.push_back(x);
                current_sums_ms.clear();
                for (long long s : next_level_sums_candidate) {
                    current_sums_ms.insert(s);
                }
            } else {
                ans_long_long.push_back(-x);
                current_sums_ms.clear();
                for (long long s : next_level_sums_candidate) {
                    current_sums_ms.insert(s - x);
                }
                current_target_zero += x;
            }
        }

        std::vector<int> result_int;
        for (long long val : ans_long_long) {
            result_int.push_back(static_cast<int>(val));
        }
        return result_int;
    }
};