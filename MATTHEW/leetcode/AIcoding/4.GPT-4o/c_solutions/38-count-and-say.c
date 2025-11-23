char *countAndSay(int n){
    if (n == 1) return "1";
    char *prev = countAndSay(n - 1);
    int len = strlen(prev);
    char *result = (char *)malloc(2 * len + 1);
    int j = 0, count = 1;

    for (int i = 1; i < len; i++) {
        if (prev[i] == prev[i - 1]) {
            count++;
        } else {
            j += sprintf(result + j, "%d%c", count, prev[i - 1]);
            count = 1;
        }
    }
    j += sprintf(result + j, "%d%c", count, prev[len - 1]);

    free(prev);
    return result;
}