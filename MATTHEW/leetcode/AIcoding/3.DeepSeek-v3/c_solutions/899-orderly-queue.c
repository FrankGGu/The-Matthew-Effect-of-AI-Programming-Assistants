int compare(const void *a, const void *b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

char* orderlyQueue(char* s, int k) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));

    if (k == 1) {
        char* doubled = (char*)malloc((2 * n + 1) * sizeof(char));
        strcpy(doubled, s);
        strcat(doubled, s);

        strcpy(result, s);
        for (int i = 1; i < n; i++) {
            if (strncmp(doubled + i, result, n) < 0) {
                strncpy(result, doubled + i, n);
            }
        }
        result[n] = '\0';
        free(doubled);
        return result;
    } else {
        strcpy(result, s);
        qsort(result, n, sizeof(char), (int(*)(const void*, const void*))strcmp);
        return result;
    }
}