char **findSequence(char **strings, int stringsSize, int *returnSize) {
    char **result = (char **)malloc(stringsSize * sizeof(char *));
    *returnSize = 0;
    for (int i = 0; i < stringsSize; i++) {
        int j;
        for (j = 0; j < *returnSize; j++) {
            if (strcmp(result[j], strings[i]) == 0) {
                break;
            }
        }
        if (j == *returnSize) {
            result[*returnSize] = strings[i];
            (*returnSize)++;
        }
    }
    return result;
}