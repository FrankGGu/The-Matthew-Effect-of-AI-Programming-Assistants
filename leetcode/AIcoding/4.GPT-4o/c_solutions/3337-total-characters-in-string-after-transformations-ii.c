int countCharacters(char **words, int wordsSize, char *chars) {
    int charCount[26] = {0};
    for (int i = 0; chars[i]; i++) {
        charCount[chars[i] - 'a']++;
    }

    int totalLength = 0;
    for (int i = 0; i < wordsSize; i++) {
        int wordCount[26] = {0};
        for (int j = 0; words[i][j]; j++) {
            wordCount[words[i][j] - 'a']++;
        }

        int canForm = 1;
        for (int k = 0; k < 26; k++) {
            if (wordCount[k] > charCount[k]) {
                canForm = 0;
                break;
            }
        }

        if (canForm) {
            totalLength += strlen(words[i]);
        }
    }

    return totalLength;
}