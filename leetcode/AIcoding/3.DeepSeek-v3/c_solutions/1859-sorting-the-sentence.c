char* sortSentence(char* s) {
    char words[9][201];
    int indices[9];
    int count = 0;

    char* token = strtok(s, " ");
    while (token != NULL) {
        int len = strlen(token);
        int index = token[len - 1] - '1';
        token[len - 1] = '\0';
        strcpy(words[index], token);
        indices[count++] = index;
        token = strtok(NULL, " ");
    }

    static char result[2000];
    result[0] = '\0';

    for (int i = 0; i < count; i++) {
        strcat(result, words[i]);
        if (i < count - 1) {
            strcat(result, " ");
        }
    }

    return result;
}