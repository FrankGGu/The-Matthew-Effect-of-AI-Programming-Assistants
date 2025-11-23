#include <vector>

class Solution {
public:
    const int MOD = 1337;

    long long pow_mod(long long base, int exp) {
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

    int superPow(int a, std::vector<int>& b) {
        if (b.empty()) {
            return 1;
        }

        long long result = 1;
        a %= MOD;

        for (int digit : b) {
            result = (pow_mod(result, 10) * pow_mod(a, digit)) % MOD;
        }

        return static_cast<int>(result);
    }
};