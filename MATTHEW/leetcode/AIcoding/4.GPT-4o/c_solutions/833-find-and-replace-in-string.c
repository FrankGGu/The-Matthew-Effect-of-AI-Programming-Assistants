char *findReplaceString(char *s, int sSize, char **indices, char **sources, char **targets, int indicesSize) {
    char *result = (char *)malloc(10000 * sizeof(char));
    int resultIndex = 0;
    int i = 0;

    while (i < sSize) {
        int j;
        for (j = 0; j < indicesSize; j++) {
            if (i == atoi(indices[j]) && strncmp(s + i, sources[j], strlen(sources[j])) == 0) {
                strcpy(result + resultIndex, targets[j]);
                resultIndex += strlen(targets[j]);
                i += strlen(sources[j]);
                break;
            }
        }
        if (j == indicesSize) {
            result[resultIndex++] = s[i++];
        }
    }
    result[resultIndex] = '\0';
    return result;
}