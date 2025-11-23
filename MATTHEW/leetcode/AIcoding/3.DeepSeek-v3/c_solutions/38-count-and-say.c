char* countAndSay(int n) {
    if (n == 1) return "1";

    char* prev = countAndSay(n - 1);
    int len = strlen(prev);
    char* result = malloc(2 * len + 1);
    int idx = 0;

    for (int i = 0; i < len; i++) {
        int count = 1;
        while (i + 1 < len && prev[i] == prev[i + 1]) {
            count++;
            i++;
        }
        result[idx++] = count + '0';
        result[idx++] = prev[i];
    }
    result[idx] = '\0';

    return result;
}