char *sortSentence(char *s) {
    int len = strlen(s);
    char *result = (char *)malloc(len + 1);
    char *words[100] = {0};
    int index = 0;
    char *token = strtok(s, " ");

    while (token) {
        int wordLen = strlen(token);
        words[token[wordLen - 1] - '0' - 1] = (char *)malloc(wordLen);
        strncpy(words[token[wordLen - 1] - '0' - 1], token, wordLen - 1);
        words[token[wordLen - 1] - '0' - 1][wordLen - 1] = '\0';
        index++;
        token = strtok(NULL, " ");
    }

    for (int i = 0; i < index; i++) {
        if (i > 0) strcat(result, " ");
        strcat(result, words[i]);
        free(words[i]);
    }

    return result;
}