int numDecodings(char* s) {
    int n = strlen(s);
    if (n == 0) return 0;

    long long mod = 1000000007;
    long long dp1 = 1, dp2 = 0;

    for (int i = 0; i < n; i++) {
        long long current = 0;

        if (s[i] == '*') {
            current = (current + 9 * dp1) % mod;
        } else if (s[i] != '0') {
            current = (current + dp1) % mod;
        }

        if (i > 0) {
            if (s[i-1] == '*' && s[i] == '*') {
                current = (current + 15 * dp2) % mod;
            } else if (s[i-1] == '*') {
                if (s[i] >= '0' && s[i] <= '6') {
                    current = (current + 2 * dp2) % mod;
                } else {
                    current = (current + dp2) % mod;
                }
            } else if (s[i] == '*') {
                if (s[i-1] == '1') {
                    current = (current + 9 * dp2) % mod;
                } else if (s[i-1] == '2') {
                    current = (current + 6 * dp2) % mod;
                }
            } else {
                int two_digit = (s[i-1] - '0') * 10 + (s[i] - '0');
                if (two_digit >= 10 && two_digit <= 26) {
                    current = (current + dp2) % mod;
                }
            }
        }

        dp2 = dp1;
        dp1 = current;
    }

    return (int)dp1;
}