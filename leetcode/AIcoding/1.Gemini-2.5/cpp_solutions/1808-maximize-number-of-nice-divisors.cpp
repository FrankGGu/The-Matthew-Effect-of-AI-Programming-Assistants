class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long MOD = 1e9 + 7;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    int maxNiceDivisors(int primeFactors) {
        long long MOD = 1e9 + 7;

        if (primeFactors == 1) {
            return 1;
        }
        if (primeFactors == 2) {
            return 2;
        }
        if (primeFactors == 3) {
            return 3;
        }

        if (primeFactors % 3 == 0) {
            return power(3, primeFactors / 3);
        } else if (primeFactors % 3 == 1) {
            // primeFactors = 3k + 1. Best to use 3^(k-1) * 4.
            // For primeFactors = 4, 4 = 2+2, product 4.
            // For primeFactors = 7, 7 = 3+2+2, product 12.
            return (power(3, (primeFactors - 4) / 3) * 4) % MOD;
        } else { // primeFactors % 3 == 2
            // primeFactors = 3k + 2. Best to use 3^k * 2.
            // For primeFactors = 5, 5 = 3+2, product 6.
            return (power(3, (primeFactors - 2) / 3) * 2) % MOD;
        }
    }
};