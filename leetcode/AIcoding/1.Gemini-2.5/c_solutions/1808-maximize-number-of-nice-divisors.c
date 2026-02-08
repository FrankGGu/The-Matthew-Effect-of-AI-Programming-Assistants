long long power(long long base, long long exp) {
    long long res = 1;
    long long mod = 1000000007;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int maxNiceDivisors(int primeFactors) {
    if (primeFactors == 1) {
        return 1;
    }

    long long mod = 1000000007;

    if (primeFactors % 3 == 0) {
        // If primeFactors = 3k, maximize product by using k threes: 3 * 3 * ... * 3
        return (int)power(3, primeFactors / 3);
    } else if (primeFactors % 3 == 1) {
        // If primeFactors = 3k + 1, and primeFactors >= 4
        // We can't use 3s and a 1 (1 is suboptimal).
        // Instead, convert one 3 and one 1 into two 2s.
        // So, (k-1) threes and two 2s: 3^(k-1) * 2 * 2 = 3^(k-1) * 4
        // k = (primeFactors - 1) / 3
        // Exponent for 3 is k-1 = (primeFactors - 1) / 3 - 1 = (primeFactors - 4) / 3
        long long exp_3 = (primeFactors - 4) / 3;
        long long res = power(3, exp_3);
        res = (res * 4) % mod;
        return (int)res;
    } else { // primeFactors % 3 == 2
        // If primeFactors = 3k + 2
        // Maximize product by using k threes and one 2: 3^k * 2
        // k = primeFactors / 3
        long long exp_3 = primeFactors / 3;
        long long res = power(3, exp_3);
        res = (res * 2) % mod;
        return (int)res;
    }
}