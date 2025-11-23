int countBalancedPermutations(int n) {
    if (n % 2 != 0) return 0;
    long long fact = 1;
    for (int i = 1; i <= n; i++) {
        fact = (fact * i) % 1000000007;
    }
    long long half_fact = 1;
    for (int i = 1; i <= n / 2; i++) {
        half_fact = (half_fact * i) % 1000000007;
    }
    half_fact = (half_fact * half_fact) % 1000000007;
    long long result = (fact * modInverse(half_fact, 1000000007)) % 1000000007;
    return (int) result;
}

long long modInverse(long long a, long long p) {
    long long res = 1;
    long long exp = p - 2;
    while (exp) {
        if (exp % 2) res = (res * a) % p;
        a = (a * a) % p;
        exp /= 2;
    }
    return res;
}