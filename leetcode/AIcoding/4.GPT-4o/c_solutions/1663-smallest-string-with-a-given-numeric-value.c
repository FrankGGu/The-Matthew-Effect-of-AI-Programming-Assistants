char *getSmallestString(int n, int k) {
    char *result = (char *)malloc(n + 1);
    result[n] = '\0';

    for (int i = 0; i < n; i++) {
        int remaining = n - i - 1;
        for (char c = 'a'; c <= 'z'; c++) {
            int value = c - 'a' + 1;
            if (k - value <= 26 * remaining) {
                result[i] = c;
                k -= value;
                break;
            }
        }
    }

    return result;
}