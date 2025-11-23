char ** removeComments(char ** source, int sourceSize, int* returnSize) {
    char **result = malloc(100 * sizeof(char *));
    int resultIndex = 0;
    char *currentLine = malloc(1000 * sizeof(char));
    int inBlock = 0, currentLineLen = 0;

    for (int i = 0; i < sourceSize; i++) {
        char *line = source[i];
        for (int j = 0; line[j] != '\0'; j++) {
            if (inBlock) {
                if (line[j] == '*' && line[j + 1] == '/') {
                    inBlock = 0;
                    j++;
                }
            } else {
                if (line[j] == '/' && line[j + 1] == '*') {
                    inBlock = 1;
                    j++;
                } else if (line[j] == '/' && line[j + 1] == '/') {
                    break;
                } else {
                    currentLine[currentLineLen++] = line[j];
                }
            }
        }
        if (!inBlock && currentLineLen > 0) {
            currentLine[currentLineLen] = '\0';
            result[resultIndex++] = strdup(currentLine);
            currentLineLen = 0;
        }
    }

    if (currentLineLen > 0 && !inBlock) {
        currentLine[currentLineLen] = '\0';
        result[resultIndex++] = strdup(currentLine);
    }

    free(currentLine);
    *returnSize = resultIndex;
    return result;
}