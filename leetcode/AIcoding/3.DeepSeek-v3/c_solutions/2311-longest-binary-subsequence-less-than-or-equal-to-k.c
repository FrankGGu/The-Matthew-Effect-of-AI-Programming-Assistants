int longestSubsequence(char* s, int k) {
    int n = strlen(s);
    int res = 0;
    long long val = 0;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '0') {
            res++;
        } else {
            if (res < 32 && val + (1LL << res) <= k) {
                val += (1LL << res);
                res++;
            }
        }
    }

    return res;
}