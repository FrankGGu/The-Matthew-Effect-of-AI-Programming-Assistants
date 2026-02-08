#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long sumOfKSubarrays(vector<int>& nums, int k, int m) {
        int n = nums.size();

        vector<long long> P(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            P[i + 1] = P[i] + nums[i];
        }

        vector<long long> all_p = P;
        sort(all_p.begin(), all_p.end());
        all_p.erase(unique(all_p.begin(), all_p.end()), all_p.end());
        int U = all_p.size();

        auto get_coord = [&](long long val) {
            return lower_bound(all_p.begin(), all_p.end(), val) - all_p.begin() + 1;
        };

        auto check = [&](long long x) {
            pair<long long, __int128> res = {0, 0};
            vector<long long> bit_count(U + 1, 0);
            vector<__int128> bit_sum(U + 1, 0);

            auto add = [&](int idx, long long p_val) {
                for (; idx <= U; idx += idx & -idx) {
                    bit_count[idx]++;
                    bit_sum[idx] += p_val;
                }
            };

            auto query = [&](int idx) {
                pair<long long, __int128> qr = {0, 0};
                for (; idx > 0; idx -= idx & -idx) {
                    qr.first += bit_count[idx];
                    qr.second += bit_sum[idx];
                }
                return qr;
            };

            add(get_coord(P[0]), P[0]);

            for (int j = m; j <= n; ++j) {
                long long target_val = P[j] - x;
                int target_coord = upper_bound(all_p.begin(), all_p.end(), target_val) - all_p.begin();

                if (target_coord > 0) {
                    pair<long long, __int128> qr = query(target_coord);
                    long long num_valid_i = qr.first;
                    __int128 sum_of_valid_Pi = qr.second;

                    res.first += num_valid_i;
                    res.second += static_cast<__int128>(num_valid_i) * P[j] - sum_of_valid_Pi;
                }

                add(get_coord(P[j - m + 1]), P[j - m + 1]);
            }
            return res;
        };

        long long min_p = 0, max_p = 0;
        for(long long val : P) {
            min_p = min(min_p, val);
            max_p = max(max_p, val);
        }

        long long low = min_p - max_p - 1;
        long long high = max_p - min_p + 1;
        long long k_th_sum = low;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (mid == low - 1) mid = low; // handle large range
            if (check(mid).first >= k) {
                k_th_sum = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        pair<long long, __int128> result = check(k_th_sum);
        long long count = result.first;
        __int128 total_sum = result.second;

        total_sum -= static_cast<__int128>(count - k) * k_th_sum;

        return static_cast<long long>(total_sum);
    }
};