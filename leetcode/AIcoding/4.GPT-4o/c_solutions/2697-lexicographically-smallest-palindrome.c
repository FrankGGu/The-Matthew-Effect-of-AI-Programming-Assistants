char *makeSmallestPalindrome(char *s) {
    int n = strlen(s);
    char *result = (char *)malloc(n + 1);
    for (int i = 0; i < n / 2; i++) {
        result[i] = result[n - 1 - i] = s[i] < s[n - 1 - i] ? s[i] : s[n - 1 - i];
    }
    if (n % 2 == 1) {
        result[n / 2] = s[n / 2];
    }
    result[n] = '\0';
    return result;
}