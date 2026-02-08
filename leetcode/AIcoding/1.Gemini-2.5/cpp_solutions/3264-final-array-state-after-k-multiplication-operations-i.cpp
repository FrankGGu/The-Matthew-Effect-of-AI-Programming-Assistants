#include <vector>

const int MOD = 1e9 + 7;

long long power(long long base, int exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

class Solution {
public:
    std::vector<int> finalArrayState(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<int> result(n);

        for (int i = 0; i < n; ++i) {
            long long factor_base = (long long)i + 1;
            long long multiplier = power(factor_base, k);
            result[i] = (int)(((long long)nums[i] * multiplier) % MOD);
        }
        return result;
    }
};