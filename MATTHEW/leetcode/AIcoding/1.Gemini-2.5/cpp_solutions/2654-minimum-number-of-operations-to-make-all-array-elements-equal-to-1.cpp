#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums) {
        int n = nums.size();

        int ones_count = 0;
        for (int x : nums) {
            if (x == 1) {
                ones_count++;
            }
        }

        if (ones_count > 0) {
            return n - ones_count;
        }

        int overall_gcd = nums[0];
        for (int i = 1; i < n; ++i) {
            overall_gcd = std::gcd(overall_gcd, nums[i]);
            if (overall_gcd == 1) {
                break;
            }
        }

        if (overall_gcd != 1) {
            return -1;
        }

        int min_len = n + 1;

        for (int i = 0; i < n; ++i) {
            int current_gcd = nums[i];
            for (int j = i + 1; j < n; ++j) {
                current_gcd = std::gcd(current_gcd, nums[j]);
                if (current_gcd == 1) {
                    min_len = std::min(min_len, j - i + 1);
                    break;
                }
            }
        }

        return (min_len - 1) + (n - 1);
    }
};