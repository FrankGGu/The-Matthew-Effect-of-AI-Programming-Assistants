#include <iostream>
#include <vector>
#include <cmath>
#include <numeric>
#include <algorithm>

class Solution {
private:
    int solve_segment(const std::vector<int>& segment) {
        int n = segment.size();
        if (n < 2) {
            return 0;
        }

        std::vector<int> neg_prefix(n + 1, 0);
        std::vector<long double> log_prefix(n + 1, 0.0L);

        for (int i = 0; i < n; ++i) {
            neg_prefix[i + 1] = neg_prefix[i] + (segment[i] < 0);
            log_prefix[i + 1] = log_prefix[i] + log(std::abs((long double)segment[i]));
        }

        int max_len = 0;
        for (int mid = 1; mid < n; ++mid) {
            for (int k = 1; k <= std::min(mid, n - mid); ++k) {
                int neg_left = neg_prefix[mid] - neg_prefix[mid - k];
                int neg_right = neg_prefix[mid + k] - neg_prefix[mid];

                if (neg_left % 2 == neg_right % 2) {
                    long double log_sum_left = log_prefix[mid] - log_prefix[mid - k];
                    long double log_sum_right = log_prefix[mid + k] - log_prefix[mid];
                    if (std::abs(log_sum_left - log_sum_right) < 1e-9) {
                        max_len = std::max(max_len, 2 * k);
                    }
                }
            }
        }
        return max_len;
    }

public:
    int maximumSubarrayWithEqualProducts(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return 0;
        }

        int max_len = 0;

        bool has_zero = false;
        for(int x : nums) {
            if (x == 0) {
                has_zero = true;
                break;
            }
        }

        if (has_zero) {
            std::vector<int> prev_zero(n, -1);
            if (nums[0] == 0) prev_zero[0] = 0;
            for (int i = 1; i < n; ++i) {
                if (nums[i] == 0) prev_zero[i] = i;
                else prev_zero[i] = prev_zero[i - 1];
            }

            std::vector<int> next_zero(n, n);
            if (n > 0 && nums[n - 1] == 0) next_zero[n - 1] = n - 1;
            for (int i = n - 2; i >= 0; --i) {
                if (nums[i] == 0) next_zero[i] = i;
                else next_zero[i] = next_zero[i + 1];
            }

            for (int m = 1; m < n; ++m) {
                int pz = prev_zero[m - 1];
                int nz = next_zero[m];

                if (pz != -1 && nz != n) {
                    int k_min_req = std::max(m - pz, nz - m + 1);
                    int k_max_poss = std::min(m, n - m);
                    if (k_min_req <= k_max_poss) {
                       max_len = std::max(max_len, 2 * k_max_poss);
                    }
                }
            }
        }

        int last_split = -1;
        for (int i = 0; i <= n; ++i) {
            if (i == n || nums[i] == 0) {
                if (i > last_split + 1) {
                    std::vector<int> segment;
                    for (int j = last_split + 1; j < i; ++j) {
                        segment.push_back(nums[j]);
                    }
                    max_len = std::max(max_len, solve_segment(segment));
                }
                last_split = i;
            }
        }

        return max_len;
    }
};