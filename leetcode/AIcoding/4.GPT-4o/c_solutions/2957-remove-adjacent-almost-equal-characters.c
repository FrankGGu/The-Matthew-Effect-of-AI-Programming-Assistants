char *removeAdjacent(char *s, int *returnSize) {
    int n = strlen(s);
    char *result = (char *)malloc(n + 1);
    int index = 0;

    for (int i = 0; i < n; i++) {
        if (index > 0 && abs(s[i] - result[index - 1]) <= 1) {
            index--;
        } else {
            result[index++] = s[i];
        }
    }

    result[index] = '\0';
    *returnSize = index;
    return result;
}