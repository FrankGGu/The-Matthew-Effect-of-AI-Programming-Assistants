char** divideString(char* s, int k, char fill, int* returnSize) {
    int len = strlen(s);
    int groups = (len + k - 1) / k;
    *returnSize = groups;

    char** result = (char**)malloc(groups * sizeof(char*));
    for (int i = 0; i < groups; i++) {
        result[i] = (char*)malloc((k + 1) * sizeof(char));
        for (int j = 0; j < k; j++) {
            int idx = i * k + j;
            if (idx < len) {
                result[i][j] = s[idx];
            } else {
                result[i][j] = fill;
            }
        }
        result[i][k] = '\0';
    }

    return result;
}