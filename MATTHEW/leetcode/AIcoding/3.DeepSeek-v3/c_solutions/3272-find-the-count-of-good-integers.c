#define MOD 1000000007

long long factorial[11];
long long inv_factorial[11];

long long power(long long base, long long exp) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    return result;
}

void precompute_factorials() {
    factorial[0] = 1;
    for (int i = 1; i <= 10; i++) {
        factorial[i] = (factorial[i-1] * i) % MOD;
    }
    for (int i = 0; i <= 10; i++) {
        inv_factorial[i] = power(factorial[i], MOD-2);
    }
}

long long nCr(int n, int r) {
    if (r < 0 || r > n) return 0;
    return (factorial[n] * inv_factorial[r] % MOD) * inv_factorial[n-r] % MOD;
}

long long countGoodIntegers(int n, int k) {
    precompute_factorials();

    int half = (n + 1) / 2;
    long long total = 0;

    for (int d = 1; d <= 9; d++) {
        int freq[10] = {0};
        freq[d]++;

        long long dp[11][half+1][k];
        memset(dp, 0, sizeof(dp));
        dp[1][1][d % k] = 1;

        for (int digit = 0; digit <= 9; digit++) {
            for (int len = 1; len <= half; len++) {
                for (int rem = 0; rem < k; rem++) {
                    if (dp[digit][len][rem] == 0) continue;

                    if (digit < 9) {
                        dp[digit+1][len][rem] = (dp[digit+1][len][rem] + dp[digit][len][rem]) % MOD;
                    }

                    if (len < half) {
                        int new_rem = (rem * 10 + digit) % k;
                        dp[digit][len+1][new_rem] = (dp[digit][len+1][new_rem] + dp[digit][len][rem]) % MOD;
                    }
                }
            }
        }

        for (int len = 1; len <= half; len++) {
            for (int rem = 0; rem < k; rem++) {
                if (dp[10][len][rem] == 0) continue;

                int other_len = n - len;
                if (other_len < len) continue;

                int other_rem = (k - rem) % k;

                if (other_len == len) {
                    if (rem == other_rem) {
                        total = (total + dp[10][len][rem]) % MOD;
                    }
                } else {
                    for (int first_digit = 1; first_digit <= 9; first_digit++) {
                        int new_rem = (other_rem - first_digit * power(10, other_len - 1) % k + k) % k;
                        total = (total + dp[10][len][rem] * dp[10][other_len-1][new_rem] % MOD) % MOD;
                    }
                }
            }
        }
    }

    return total;
}