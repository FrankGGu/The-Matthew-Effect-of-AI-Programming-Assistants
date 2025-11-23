#include <vector>
#include <map>
#include <algorithm>
#include <limits>

using namespace std;

void update_products(map<long long, pair<long long, long long>>& dp_map, long long sum, long long new_prod) {
    if (new_prod > 0) {
        if (dp_map.count(sum)) {
            dp_map[sum].first = max(dp_map[sum].first, new_prod);
        } else {
            dp_map[sum] = {new_prod, numeric_limits<long long>::max()};
        }
    } else if (new_prod < 0) {
        if (dp_map.count(sum)) {
            dp_map[sum].second = min(dp_map[sum].second, new_prod);
        } else {
            dp_map[sum] = {numeric_limits<long long>::min(), new_prod};
        }
    } else { // new_prod == 0
        if (dp_map.count(sum)) {
            dp_map[sum].first = max(dp_map[sum].first, 0LL);
        } else {
            dp_map[sum] = {0LL, numeric_limits<long long>::max()};
        }
    }
}

class Solution {
public:
    long long maxProduct(vector<int>& nums, long long k) {
        // dp[0]: map for odd-length subsequences (last element added)
        // dp[1]: map for even-length subsequences (last element subtracted)
        // map value: pair<max_positive_product, min_negative_product>
        // Use LLONG_MIN for max_positive_product if no positive product yet.
        // Use LLONG_MAX for min_negative_product if no negative product yet.
        vector<map<long long, pair<long long, long long>>> dp(2);

        for (int num_val : nums) {
            long long num = num_val;

            map<long long, pair<long long, long long>> next_dp0 = dp[0];
            map<long long, pair<long long, long long>> next_dp1 = dp[1];

            // Case 1: num starts a new subsequence. Length 1 (odd).
            update_products(next_dp0, num, num);

            // Case 2: Extend subsequences from dp[0] (odd length, last element added)
            // num is subtracted. New length is even.
            for (auto const& [s, prods] : dp[0]) {
                long long pos_p = prods.first;
                long long neg_p = prods.second;
                long long new_s = s - num;

                if (pos_p != numeric_limits<long long>::min()) {
                    update_products(next_dp1, new_s, pos_p * num);
                }
                if (neg_p != numeric_limits<long long>::max()) {
                    update_products(next_dp1, new_s, neg_p * num);
                }
            }

            // Case 3: Extend subsequences from dp[1] (even length, last element subtracted)
            // num is added. New length is odd.
            for (auto const& [s, prods] : dp[1]) {
                long long pos_p = prods.first;
                long long neg_p = prods.second;
                long long new_s = s + num;

                if (pos_p != numeric_limits<long long>::min()) {
                    update_products(next_dp0, new_s, pos_p * num);
                }
                if (neg_p != numeric_limits<long long>::max()) {
                    update_products(next_dp0, new_s, neg_p * num);
                }
            }

            dp[0] = next_dp0;
            dp[1] = next_dp1;
        }

        long long ans = -1;

        // Check dp[0] (odd length subsequences) for sum k
        if (dp[0].count(k)) {
            long long max_pos = dp[0][k].first;
            long long min_neg = dp[0][k].second;
            if (max_pos != numeric_limits<long long>::min()) {
                ans = max(ans, max_pos);
            }
            if (min_neg != numeric_limits<long long>::max()) {
                ans = max(ans, min_neg);
            }
        }

        // Check dp[1] (even length subsequences) for sum k
        if (dp[1].count(k)) {
            long long max_pos = dp[1][k].first;
            long long min_neg = dp[1][k].second;
            if (max_pos != numeric_limits<long long>::min()) {
                ans = max(ans, max_pos);
            }
            if (min_neg != numeric_limits<long long>::max()) {
                ans = max(ans, min_neg);
            }
        }

        return ans;
    }
};