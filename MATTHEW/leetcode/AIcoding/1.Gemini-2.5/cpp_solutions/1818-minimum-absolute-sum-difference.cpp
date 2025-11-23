#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath> // For std::abs

class Solution {
public:
    int minAbsoluteSumDiff(std::vector<int>& nums1, std::vector<int>& nums2) {
        long long MOD = 1e9 + 7;
        int n = nums1.size();

        std::vector<int> sorted_nums1 = nums1;
        std::sort(sorted_nums1.begin(), sorted_nums1.end());

        long long total_diff_sum = 0;
        long long max_reduction = 0;

        for (int i = 0; i < n; ++i) {
            long long current_diff = std::abs(static_cast<long long>(nums1[i]) - nums2[i]);
            total_diff_sum += current_diff;

            long long target = nums2[i];
            auto it = std::lower_bound(sorted_nums1.begin(), sorted_nums1.end(), target);

            long long min_possible_diff = current_diff; 

            if (it != sorted_nums1.end()) {
                min_possible_diff = std::min(min_possible_diff, std::abs(static_cast<long long>(*it) - target));
            }
            if (it != sorted_nums1.begin()) {
                min_possible_diff = std::min(min_possible_diff, std::abs(static_cast<long long>(*(it - 1)) - target));
            }

            max_reduction = std::max(max_reduction, current_diff - min_possible_diff);
        }

        return (total_diff_sum - max_reduction) % MOD;
    }
};