int minimumLengthEncoding(char **words, int wordsSize) {
    int totalLength = 0;
    char *set[10000] = {0};
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        set[count++] = words[i];
    }

    for (int i = 0; i < count; i++) {
        int j;
        for (j = 0; j < count; j++) {
            if (i != j && strstr(set[j], set[i]) == set[j]) {
                break;
            }
        }
        if (j == count) {
            totalLength += strlen(set[i]) + 1;
        }
    }

    return totalLength;
}