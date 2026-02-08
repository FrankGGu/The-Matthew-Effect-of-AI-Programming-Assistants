#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minSumOfLengths(std::vector<int>& arr, int target) {
        int n = arr.size();
        std::vector<int> dp(n, 1000000007); 
        int min_total_length = 1000000007; 

        int current_sum = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            current_sum += arr[right];

            while (current_sum > target && left <= right) {
                current_sum -= arr[left];
                left++;
            }

            if (right > 0) {
                dp[right] = dp[right - 1];
            }

            if (current_sum == target) {
                int current_length = right - left + 1;

                if (left > 0 && dp[left - 1] != 1000000007) {
                    min_total_length = std::min(min_total_length, dp[left - 1] + current_length);
                }

                dp[right] = std::min(dp[right], current_length);
            }
        }

        if (min_total_length == 1000000007) {
            return -1;
        } else {
            return min_total_length;
        }
    }
};