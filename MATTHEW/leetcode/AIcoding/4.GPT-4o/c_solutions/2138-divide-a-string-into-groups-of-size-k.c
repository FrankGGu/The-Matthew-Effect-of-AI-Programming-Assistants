char **divideString(char *s, int k, char fill, int *returnSize) {
    int len = strlen(s);
    int groupCount = (len + k - 1) / k;
    char **result = (char **)malloc(groupCount * sizeof(char *));

    for (int i = 0; i < groupCount; i++) {
        result[i] = (char *)malloc((k + 1) * sizeof(char));
        for (int j = 0; j < k; j++) {
            int index = i * k + j;
            if (index < len) {
                result[i][j] = s[index];
            } else {
                result[i][j] = fill;
            }
        }
        result[i][k] = '\0';
    }

    *returnSize = groupCount;
    return result;
}