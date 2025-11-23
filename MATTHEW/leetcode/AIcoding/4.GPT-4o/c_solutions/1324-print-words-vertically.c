char **printVertically(char *s, int *returnSize) {
    int maxLen = 0, row = 0;
    char **result = NULL;
    char *token = strtok(s, " ");

    while (token) {
        int len = strlen(token);
        if (len > maxLen) maxLen = len;
        row++;
        token = strtok(NULL, " ");
    }

    result = (char **)malloc(row * sizeof(char *));
    for (int i = 0; i < row; i++) {
        result[i] = (char *)malloc((maxLen + 1) * sizeof(char));
        memset(result[i], ' ', maxLen);
        result[i][maxLen] = '\0';
    }

    strtok(s, " ");
    int col = 0;
    while (s) {
        for (int i = 0; i < strlen(s); i++) {
            result[i][col] = s[i];
        }
        col++;
        s = strtok(NULL, " ");
    }

    *returnSize = maxLen;
    return result;
}