int compare(const void* a, const void* b) {
    char* s1 = *(char**)a;
    char* s2 = *(char**)b;
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    if (len1 != len2) {
        return len1 - len2;
    }
    return 0;
}

char* arrangeWords(char* text) {
    if (text == NULL) return NULL;

    int len = strlen(text);
    if (len == 0) return text;

    text[0] = tolower(text[0]);

    char** words = (char**)malloc(len * sizeof(char*));
    int wordCount = 0;

    char* token = strtok(text, " ");
    while (token != NULL) {
        words[wordCount++] = token;
        token = strtok(NULL, " ");
    }

    qsort(words, wordCount, sizeof(char*), compare);

    int resultLen = 0;
    for (int i = 0; i < wordCount; i++) {
        resultLen += strlen(words[i]) + 1;
    }

    char* result = (char*)malloc(resultLen * sizeof(char));
    int pos = 0;

    for (int i = 0; i < wordCount; i++) {
        if (i == 0) {
            words[i][0] = toupper(words[i][0]);
        }
        strcpy(result + pos, words[i]);
        pos += strlen(words[i]);
        if (i < wordCount - 1) {
            result[pos++] = ' ';
        }
    }
    result[pos] = '\0';

    free(words);
    return result;
}