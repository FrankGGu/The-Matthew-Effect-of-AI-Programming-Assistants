long long power(long long base, long long exp) {
    long long res = 1;
    long long mod = 1000000007;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int countGoodNumbers(long long n) {
    long long mod = 1000000007;
    long long num_even_pos = (n + 1) / 2;
    long long num_odd_pos = n / 2;

    long long ans_even = power(5, num_even_pos);
    long long ans_odd = power(4, num_odd_pos);

    long long final_ans = (ans_even * ans_odd) % mod;
    return (int)final_ans;
}