#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> primePairsWithTargetSum(int n) {
        if (n < 4) {
            return {-1, -1};
        }

        std::vector<bool> is_prime(n + 1, true);
        is_prime[0] = false;
        is_prime[1] = false;

        for (int p = 2; p * p <= n; ++p) {
            if (is_prime[p]) {
                for (int multiple = p * p; multiple <= n; multiple += p)
                    is_prime[multiple] = false;
            }
        }

        for (int i = 2; i <= n / 2; ++i) {
            if (is_prime[i] && is_prime[n - i]) {
                return {i, n - i};
            }
        }

        return {-1, -1};
    }
};