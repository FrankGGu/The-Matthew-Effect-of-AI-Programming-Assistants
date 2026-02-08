#include <vector>

class Solution {
public:
    std::vector<int> rangeProductQueries(int n, std::vector<std::vector<int>>& queries) {
        long long mod = 1e9 + 7;

        auto power = [&](long long base, long long exp) {
            long long res = 1;
            base %= mod;
            while (exp > 0) {
                if (exp % 2 == 1) res = (res * base) % mod;
                base = (base * base) % mod;
                exp /= 2;
            }
            return res;
        };

        std::vector<int> bits;
        for (int i = 0; i < 31; ++i) {
            if ((n >> i) & 1) {
                bits.push_back(i);
            }
        }

        int m = bits.size();
        std::vector<long long> prefix_sums(m + 1, 0);
        for (int i = 0; i < m; ++i) {
            prefix_sums[i + 1] = prefix_sums[i] + bits[i];
        }

        std::vector<int> result;
        for (const auto& q : queries) {
            int left = q[0];
            int right = q[1];

            long long exp_sum = prefix_sums[right + 1] - prefix_sums[left];

            long long ans = power(2, exp_sum);
            result.push_back(static_cast<int>(ans));
        }

        return result;
    }
};