char *nearestPalindromic(char *n) {
    long num = atol(n);
    int len = strlen(n);
    long candidates[3] = {pow(10, len) + 1, pow(10, len - 1) - 1, 0};
    long prefix = atol(strndup(n, (len + 1) / 2));

    for (long i = -1; i <= 1; i++) {
        long newPrefix = prefix + i;
        char str[20];
        sprintf(str, "%ld", newPrefix);
        int newLen = strlen(str);
        char candidate[20];
        for (int j = 0; j < newLen; j++) {
            candidate[j] = str[j];
        }
        for (int j = newLen - 1; j >= 0; j--) {
            candidate[newLen + j] = str[j];
        }
        candidate[2 * newLen] = '\0';
        candidates[2] = atol(candidate);
        candidates[2] = candidates[2] > 0 ? candidates[2] : LONG_MAX;
    }

    long closest = LONG_MAX;
    char *result = NULL;

    for (int i = 0; i < 3; i++) {
        if (candidates[i] != num && abs(candidates[i] - num) < abs(closest - num)) {
            closest = candidates[i];
            result = (char *)malloc(20);
            sprintf(result, "%ld", closest);
        }
    }

    return result;
}