char * rearrangeSpaces(char * text) {
    int spaceCount = 0, wordCount = 0, i = 0, j = 0, len = strlen(text);
    for (i = 0; i < len; i++) {
        if (text[i] == ' ') spaceCount++;
    }
    char **words = (char **)malloc((len + 1) * sizeof(char *));
    char *token = strtok(text, " ");
    while (token) {
        words[wordCount++] = token;
        token = strtok(NULL, " ");
    }
    int gap = wordCount > 1 ? spaceCount / (wordCount - 1) : 0;
    int extra = wordCount > 1 ? spaceCount % (wordCount - 1) : spaceCount;
    char *result = (char *)malloc((len + 1) * sizeof(char));
    for (i = 0; i < wordCount; i++) {
        for (j = 0; words[i][j]; j++) {
            result[strlen(result)] = words[i][j];
        }
        if (i < wordCount - 1) {
            for (j = 0; j < gap; j++) {
                result[strlen(result)] = ' ';
            }
        }
    }
    for (i = 0; i < extra; i++) {
        result[strlen(result)] = ' ';
    }
    result[strlen(result)] = '\0';
    return result;
}