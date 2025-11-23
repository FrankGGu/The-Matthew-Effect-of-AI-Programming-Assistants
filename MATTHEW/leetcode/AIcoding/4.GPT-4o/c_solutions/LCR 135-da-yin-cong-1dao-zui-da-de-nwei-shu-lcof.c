char *countAndSay(int n) {
    if (n == 1) return "1";

    char *prev = countAndSay(n - 1);
    int len = strlen(prev);
    char *result = (char *)malloc(2 * len + 1);
    int count = 1, j = 0;

    for (int i = 1; i <= len; i++) {
        if (i < len && prev[i] == prev[i - 1]) {
            count++;
        } else {
            j += sprintf(result + j, "%d%c", count, prev[i - 1]);
            count = 1;
        }
    }
    return result;
}