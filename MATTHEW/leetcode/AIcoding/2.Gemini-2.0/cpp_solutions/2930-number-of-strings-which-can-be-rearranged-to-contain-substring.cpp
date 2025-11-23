#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int stringCount(int n) {
        long long total = powMod(26, n, 1000000007);
        long long noL = powMod(25, n, 1000000007);
        long long noE = powMod(25, n, 1000000007);
        long long noT = powMod(25, n, 1000000007);
        long long noLE = powMod(24, n, 1000000007);
        long long noLT = powMod(24, n, 1000000007);
        long long noET = powMod(24, n, 1000000007);
        long long noLET = powMod(23, n, 1000000007);

        long long result = (total - noL - noE - noT + noLE + noLT + noET - noLET) % 1000000007;
        if (result < 0) {
            result += 1000000007;
        }
        return (int)result;
    }

private:
    long long powMod(long long base, int exp, int mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
};