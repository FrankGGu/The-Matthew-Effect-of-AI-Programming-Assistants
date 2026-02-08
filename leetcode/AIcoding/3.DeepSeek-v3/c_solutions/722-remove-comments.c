/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** removeComments(char** source, int sourceSize, int* returnSize) {
    char** result = malloc(sourceSize * sizeof(char*));
    *returnSize = 0;

    int inBlockComment = 0;
    char* buffer = malloc(100 * sourceSize * sizeof(char));
    int bufferIndex = 0;

    for (int i = 0; i < sourceSize; i++) {
        char* line = source[i];
        int lineLen = strlen(line);
        int j = 0;

        while (j < lineLen) {
            if (!inBlockComment && j + 1 < lineLen && line[j] == '/' && line[j + 1] == '/') {
                break; // Skip the rest of the line
            } else if (!inBlockComment && j + 1 < lineLen && line[j] == '/' && line[j + 1] == '*') {
                inBlockComment = 1;
                j += 2;
            } else if (inBlockComment && j + 1 < lineLen && line[j] == '*' && line[j + 1] == '/') {
                inBlockComment = 0;
                j += 2;
            } else if (!inBlockComment) {
                buffer[bufferIndex++] = line[j++];
            } else {
                j++;
            }
        }

        if (!inBlockComment && bufferIndex > 0) {
            buffer[bufferIndex] = '\0';
            result[*returnSize] = malloc((bufferIndex + 1) * sizeof(char));
            strcpy(result[*returnSize], buffer);
            (*returnSize)++;
            bufferIndex = 0;
        }
    }

    free(buffer);
    return result;
}