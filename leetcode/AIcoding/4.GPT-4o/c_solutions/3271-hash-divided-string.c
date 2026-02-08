char *hashDividedString(char *s, int k) {
    int n = strlen(s);
    char *result = (char *)malloc(n + 1);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (count == k) {
            result[i] = '-';
            count = 0;
            i++;
        }
        result[i] = s[n - 1 - count];
        count++;
    }
    result[n + (n / k)] = '\0';

    for (int i = 0, j = 0; i < n; i++) {
        if (result[i] != '-') {
            result[j++] = result[i];
        }
    }
    result[j] = '\0';

    return result;
}