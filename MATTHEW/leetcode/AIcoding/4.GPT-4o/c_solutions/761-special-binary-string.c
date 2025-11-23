char* makeLargestSpecial(char* S) {
    int count = 0, start = 0;
    char** substrings = (char**)malloc(sizeof(char*) * (strlen(S) / 2));
    int index = 0;

    for (int i = 0; i < strlen(S); i++) {
        if (S[i] == '1') count++;
        else count--;
        if (count == 0) {
            substrings[index++] = (char*)malloc((i - start + 2) * sizeof(char));
            strncpy(substrings[index - 1], S + start, i - start + 1);
            substrings[index - 1][i - start + 1] = '\0';
            start = i + 1;
        }
    }

    for (int i = 0; i < index; i++) {
        char* inner = makeLargestSpecial(substrings[i] + 1);
        substrings[i][0] = '1';
        substrings[i][1] = '\0';
        strcat(substrings[i], inner);
        strcat(substrings[i], "0");
        free(inner);
    }

    qsort(substrings, index, sizeof(char*), (int (*)(const void *, const void *))strcmp);

    char* result = (char*)malloc(sizeof(char) * (strlen(S) + 1));
    result[0] = '\0';

    for (int i = index - 1; i >= 0; i--) {
        strcat(result, substrings[i]);
        free(substrings[i]);
    }
    free(substrings);
    return result;
}