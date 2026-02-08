char* makeFancyString(char* s) {
    int n = strlen(s);
    if (n <= 2) return s;

    char* result = malloc(n + 1);
    int idx = 0;

    result[idx++] = s[0];
    result[idx++] = s[1];

    for (int i = 2; i < n; i++) {
        if (s[i] != result[idx-1] || s[i] != result[idx-2]) {
            result[idx++] = s[i];
        }
    }

    result[idx] = '\0';
    return result;
}