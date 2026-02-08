#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>
#include <limits>

class Solution {
public:
    void generate_sums(int idx, long long current_sum, int count, const std::vector<int>& half, std::vector<std::vector<long long>>& sums) {
        if (idx == half.size()) {
            sums[count].push_back(current_sum);
            return;
        }

        generate_sums(idx + 1, current_sum + half[idx], count + 1, half, sums);
        generate_sums(idx + 1, current_sum, count, half, sums);
    }

    int minimumDifference(std::vector<int>& nums) {
        int n = nums.size() / 2;
        long long total_sum = 0;
        for (int x : nums) {
            total_sum += x;
        }

        std::vector<int> first_half(nums.begin(), nums.begin() + n);
        std::vector<int> second_half(nums.begin() + n, nums.end());

        std::vector<std::vector<long long>> left_sums(n + 1);
        std::vector<std::vector<long long>> right_sums(n + 1);

        generate_sums(0, 0, 0, first_half, left_sums);
        generate_sums(0, 0, 0, second_half, right_sums);

        for (int i = 0; i <= n; ++i) {
            std::sort(left_sums[i].begin(), left_sums[i].end());
            std::sort(right_sums[i].begin(), right_sums[i].end());
        }

        long long min_diff = std::numeric_limits<long long>::max();

        for (int k = 0; k <= n; ++k) {
            int num_from_left = k;
            int num_from_right = n - k;

            if (left_sums[num_from_left].empty() || right_sums[num_from_right].empty()) {
                continue;
            }

            for (long long s1 : left_sums[num_from_left]) {
                long long target_s2 = (total_sum - 2 * s1) / 2;

                auto it = std::lower_bound(right_sums[num_from_right].begin(), right_sums[num_from_right].end(), target_s2);

                if (it != right_sums[num_from_right].end()) {
                    long long current_sum_n_elements = s1 + *it;
                    min_diff = std::min(min_diff, std::abs(2 * current_sum_n_elements - total_sum));
                }

                if (it != right_sums[num_from_right].begin()) {
                    --it;
                    long long current_sum_n_elements = s1 + *it;
                    min_diff = std::min(min_diff, std::abs(2 * current_sum_n_elements - total_sum));
                }
            }
        }

        return static_cast<int>(min_diff);
    }
};