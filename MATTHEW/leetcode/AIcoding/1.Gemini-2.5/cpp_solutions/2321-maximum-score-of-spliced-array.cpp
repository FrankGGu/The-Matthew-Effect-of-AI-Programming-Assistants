#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long kadane(const std::vector<long long>& arr) {
        long long max_so_far = 0;
        long long current_max = 0;
        for (long long x : arr) {
            current_max += x;
            if (current_max < 0) {
                current_max = 0;
            }
            max_so_far = std::max(max_so_far, current_max);
        }
        return max_so_far;
    }

    long long maximumsSplicedArray(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();

        long long sum1 = 0;
        long long sum2 = 0;

        for (int x : nums1) {
            sum1 += x;
        }
        for (int x : nums2) {
            sum2 += x;
        }

        std::vector<long long> diff1(n);
        for (int i = 0; i < n; ++i) {
            diff1[i] = nums2[i] - nums1[i];
        }
        long long max_gain1 = kadane(diff1);
        long long score_for_nums1 = sum1 + max_gain1;

        std::vector<long long> diff2(n);
        for (int i = 0; i < n; ++i) {
            diff2[i] = nums1[i] - nums2[i];
        }
        long long max_gain2 = kadane(diff2);
        long long score_for_nums2 = sum2 + max_gain2;

        return std::max(score_for_nums1, score_for_nums2);
    }
};