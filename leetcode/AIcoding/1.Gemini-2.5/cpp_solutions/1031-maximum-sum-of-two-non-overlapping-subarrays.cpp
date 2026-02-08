#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxSumTwoNoOverlap(std::vector<int>& nums, int firstLen, int secondLen) {
        int n = nums.size();

        std::vector<int> P(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            P[i+1] = P[i] + nums[i];
        }

        auto calculateMaxSum = [&](int len1, int len2) {
            int max_total_sum = 0;

            std::vector<int> max_left_len1(n, 0);
            for (int i = len1 - 1; i < n; ++i) {
                int current_sum_len1 = P[i+1] - P[i+1 - len1];
                if (i == len1 - 1) {
                    max_left_len1[i] = current_sum_len1;
                } else {
                    max_left_len1[i] = std::max(max_left_len1[i-1], current_sum_len1);
                }
            }

            std::vector<int> max_right_len2(n, 0);
            for (int i = n - len2; i >= 0; --i) {
                int current_sum_len2 = P[i + len2] - P[i];
                if (i == n - len2) {
                    max_right_len2[i] = current_sum_len2;
                } else {
                    max_right_len2[i] = std::max(max_right_len2[i+1], current_sum_len2);
                }
            }

            for (int i = len1 - 1; i <= n - len2 - 1; ++i) {
                max_total_sum = std::max(max_total_sum, max_left_len1[i] + max_right_len2[i+1]);
            }

            return max_total_sum;
        };

        int ans1 = calculateMaxSum(firstLen, secondLen);
        int ans2 = calculateMaxSum(secondLen, firstLen);

        return std::max(ans1, ans2);
    }
};