int minimumTime(char* s) {
    int n = strlen(s);
    int left = 0;
    int ans = n;

    for (int i = 0; i < n; i++) {
        left = fmin(left + (s[i] - '0') * 2, i + 1);
        ans = fmin(ans, left + n - i - 1);
    }

    return ans;
}