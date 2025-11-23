class Solution {
public:
    int maxNiceDivisors(int primeFactors) {
        if (primeFactors == 1) return 1;
        int mod = 1e9 + 7;
        int quotient = primeFactors / 3;
        int remainder = primeFactors % 3;
        if (remainder == 0) {
            return powMod(3, quotient, mod);
        } else if (remainder == 1) {
            return (powMod(3, quotient - 1, mod) * 4LL % mod;
        } else {
            return (powMod(3, quotient, mod) * 2LL % mod);
        }
    }

private:
    long long powMod(long long base, int exp, int mod) {
        long long result = 1;
        while (exp > 0) {
            if (exp % 2 == 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return result;
    }
};