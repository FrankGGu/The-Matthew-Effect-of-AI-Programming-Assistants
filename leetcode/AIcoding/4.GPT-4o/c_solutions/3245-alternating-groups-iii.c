char* alternatingGroupsIII(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc(n + 1);
    int j = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0 || s[i] != s[i - 1]) {
            result[j++] = s[i];
        }
    }
    result[j] = '\0';
    return result;
}