char * smallestString(int n) {
    char *result = (char *)malloc((n + 1) * sizeof(char));
    for (int i = 0; i < n; i++) {
        result[i] = 'a' + (i % 2);
    }
    result[n] = '\0';
    return result;
}