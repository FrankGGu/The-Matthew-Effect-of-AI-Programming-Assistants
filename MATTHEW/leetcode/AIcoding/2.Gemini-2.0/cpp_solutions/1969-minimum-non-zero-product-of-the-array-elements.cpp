#include <cmath>

class Solution {
public:
    int minNonZeroProduct(int p) {
        long long mod = 1e9 + 7;
        long long n = pow(2, p) - 1;
        long long ans = 1;
        long long base = n - 1;
        long long power = n / 2;

        while (power > 0) {
            if (power % 2 == 1) {
                ans = (ans * base) % mod;
            }
            base = (base * base) % mod;
            power /= 2;
        }

        ans = (ans * n) % mod;
        return (int)ans;
    }
};