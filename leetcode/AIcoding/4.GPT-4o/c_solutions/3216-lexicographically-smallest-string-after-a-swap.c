char * lexSmallestString(char * s, int a, int b) {
    int n = strlen(s);
    char *result = strdup(s);
    if (a == 0) return result; 

    for (int i = 0; i < n; i++) {
        if (i > 0 && b > 0) {
            if (result[i] < result[i - 1]) {
                char temp = result[i];
                result[i] = result[i - 1];
                result[i - 1] = temp;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if ((i + a) < n) {
            result[i] = 'a' + (s[i] - 'a' + a) % 26;
        }
    }

    return result;
}