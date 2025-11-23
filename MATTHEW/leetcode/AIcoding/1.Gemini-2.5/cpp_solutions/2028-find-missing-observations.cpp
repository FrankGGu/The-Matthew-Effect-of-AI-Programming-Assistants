#include <vector>
#include <numeric> // Required for std::accumulate if used

class Solution {
public:
    std::vector<int> missingRolls(std::vector<int>& rolls, int mean, int n) {
        long long sum_rolls = 0;
        for (int roll : rolls) {
            sum_rolls += roll;
        }

        long long m = rolls.size();
        long long total_rolls = m + n;
        long long target_total_sum = total_rolls * mean;
        long long target_missing_sum = target_total_sum - sum_rolls;

        if (target_missing_sum < n * 1 || target_missing_sum > n * 6) {
            return {};
        }

        std::vector<int> ans(n);
        long long base_val = target_missing_sum / n;
        long long remainder = target_missing_sum % n;

        for (int i = 0; i < n; ++i) {
            ans[i] = base_val;
            if (i < remainder) {
                ans[i]++;
            }
        }

        return ans;
    }
};