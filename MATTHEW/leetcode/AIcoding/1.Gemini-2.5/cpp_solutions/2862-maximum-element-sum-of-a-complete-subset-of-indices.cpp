#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    long long maximumSum(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<int> cores(n + 1);
        for (int i = 1; i <= n; ++i) {
            cores[i] = i;
        }

        for (int i = 2; i * i <= n; ++i) {
            int square = i * i;
            for (int j = square; j <= n; j += square) {
                while (cores[j] % square == 0) {
                    cores[j] /= square;
                }
            }
        }

        std::unordered_map<int, long long> core_sums;
        for (int i = 0; i < n; ++i) {
            int index = i + 1;
            core_sums[cores[index]] += nums[i];
        }

        long long max_sum = 0;
        for (auto const& pair : core_sums) {
            max_sum = std::max(max_sum, pair.second);
        }

        return max_sum;
    }
};