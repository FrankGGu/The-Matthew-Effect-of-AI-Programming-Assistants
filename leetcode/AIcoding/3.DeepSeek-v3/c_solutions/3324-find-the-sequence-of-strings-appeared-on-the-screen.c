char** stringSequence(char* target, int* returnSize) {
    int len = strlen(target);
    char** result = (char**)malloc((len + 1) * sizeof(char*));
    *returnSize = len + 1;

    result[0] = (char*)malloc(2 * sizeof(char));
    result[0][0] = 'a';
    result[0][1] = '\0';

    for (int i = 1; i <= len; i++) {
        result[i] = (char*)malloc((i + 2) * sizeof(char));
        strncpy(result[i], result[i - 1], i);
        result[i][i] = target[i - 1];
        result[i][i + 1] = '\0';
    }

    return result;
}