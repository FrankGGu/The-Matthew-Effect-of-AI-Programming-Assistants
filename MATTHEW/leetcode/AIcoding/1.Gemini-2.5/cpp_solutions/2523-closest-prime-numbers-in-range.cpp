#include <vector>
#include <climits>
#include <algorithm>

class Solution {
public:
    std::vector<int> closestPrimes(int left, int right) {
        std::vector<bool> is_prime(right + 1, true);
        if (right >= 0) is_prime[0] = false;
        if (right >= 1) is_prime[1] = false;

        for (int p = 2; p * p <= right; ++p) {
            if (is_prime[p]) {
                for (int multiple = p * p; multiple <= right; multiple += p)
                    is_prime[multiple] = false;
            }
        }

        int min_diff = INT_MAX;
        int ans_p1 = -1, ans_p2 = -1;
        int prev_prime = -1;

        for (int i = left; i <= right; ++i) {
            if (is_prime[i]) {
                if (prev_prime != -1) {
                    if (i - prev_prime < min_diff) {
                        min_diff = i - prev_prime;
                        ans_p1 = prev_prime;
                        ans_p2 = i;
                    }
                }
                prev_prime = i;
            }
        }

        return {ans_p1, ans_p2};
    }
};