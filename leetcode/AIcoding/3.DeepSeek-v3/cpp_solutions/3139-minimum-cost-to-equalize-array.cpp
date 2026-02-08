class Solution {
public:
    int minCostToEqualizeArray(vector<int>& nums, int cost1, int cost2) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        if (n == 1) return 0;

        int max_num = *max_element(nums.begin(), nums.end());
        long long total = 0;
        for (int num : nums) {
            total += max_num - num;
        }

        if (cost1 * 2 <= cost2) {
            return (total * cost1) % MOD;
        }

        long long res = LLONG_MAX;
        for (int t = max_num; t <= max_num + 1; ++t) {
            long long sum = 0;
            int max_diff = 0;
            for (int num : nums) {
                int diff = t - num;
                sum += diff;
                max_diff = max(max_diff, diff);
            }
            long long pairs = (sum - max_diff);
            long long cost = 0;
            if (pairs >= max_diff) {
                cost = (sum / 2) * cost2;
                if (sum % 2 != 0) {
                    cost += cost1;
                }
            } else {
                cost = pairs * cost2 + (max_diff - pairs) * cost1;
            }
            res = min(res, cost);
        }

        return res % MOD;
    }
};