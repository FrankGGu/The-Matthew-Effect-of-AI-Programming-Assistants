int numDecodings(char* s) {
    if (s[0] == '0') return 0;

    int n = strlen(s);
    int dp1 = 1, dp2 = 1;

    for (int i = 1; i < n; i++) {
        int current = 0;
        if (s[i] != '0') {
            current += dp2;
        }

        int two_digit = (s[i-1] - '0') * 10 + (s[i] - '0');
        if (two_digit >= 10 && two_digit <= 26) {
            current += dp1;
        }

        dp1 = dp2;
        dp2 = current;
    }

    return dp2;
}