int stringCount(int n) {
    if (n < 4) return 0;

    long long mod = 1e9 + 7;

    auto pow_mod = [&](long long a, long long b) {
        long long res = 1;
        while (b) {
            if (b & 1) res = res * a % mod;
            a = a * a % mod;
            b >>= 1;
        }
        return res;
    };

    long long total = pow_mod(26, n);

    long long no_l = pow_mod(25, n);
    long long no_e = no_l;
    long long no_t = no_l;

    long long no_l_no_e = pow_mod(24, n);
    long long no_l_no_t = no_l_no_e;
    long long no_e_no_t = no_l_no_e;

    long long no_l_no_e_no_t = pow_mod(23, n);

    long long result = total;
    result = (result - no_l - no_e - no_t + mod * 3) % mod;
    result = (result + no_l_no_e + no_l_no_t + no_e_no_t) % mod;
    result = (result - no_l_no_e_no_t + mod) % mod;

    return result;
}