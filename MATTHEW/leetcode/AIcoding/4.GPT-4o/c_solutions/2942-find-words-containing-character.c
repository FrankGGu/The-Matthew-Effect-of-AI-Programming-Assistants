char **findWords(char **words, int wordsSize, char *chars, int *returnSize) {
    int charCount[26] = {0};
    for (int i = 0; chars[i]; i++) {
        charCount[chars[i] - 'a']++;
    }

    char **result = (char **)malloc(wordsSize * sizeof(char *));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        int tempCount[26] = {0};
        int canForm = 1;

        for (int j = 0; words[i][j]; j++) {
            tempCount[words[i][j] - 'a']++;
            if (tempCount[words[i][j] - 'a'] > charCount[words[i][j] - 'a']) {
                canForm = 0;
                break;
            }
        }

        if (canForm) {
            result[*returnSize] = words[i];
            (*returnSize)++;
        }
    }

    return result;
}