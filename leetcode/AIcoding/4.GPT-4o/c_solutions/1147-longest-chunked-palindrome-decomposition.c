int longestDecomposition(char *s) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n / 2; i++) {
        if (s[i] == s[n - i - 1]) {
            count++;
        } else {
            break;
        }
    }
    return 2 * count + (n % 2 == 1 || count == 0 ? 1 : 0);
}