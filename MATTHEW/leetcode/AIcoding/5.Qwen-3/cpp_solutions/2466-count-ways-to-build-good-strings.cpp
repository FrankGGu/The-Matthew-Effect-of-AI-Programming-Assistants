#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countGoodNumbers(long long n) {
        const long long MOD = 1e9 + 7;
        auto powMod = [&](long long base, long long exponent) {
            long long result = 1;
            while (exponent > 0) {
                if (exponent % 2 == 1) {
                    result = (result * base) % MOD;
                }
                base = (base * base) % MOD;
                exponent /= 2;
            }
            return result;
        };
        long long evenCount = powMod(5, n / 2 + n % 2);
        long long oddCount = powMod(4, n / 2);
        return (evenCount * oddCount) % MOD;
    }
};