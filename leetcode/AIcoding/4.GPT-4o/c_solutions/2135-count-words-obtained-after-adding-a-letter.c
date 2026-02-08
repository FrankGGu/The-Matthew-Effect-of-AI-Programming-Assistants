int countWords(char ** words, int wordsSize, char * letters, int lettersSize) {
    int count = 0;
    int letterCount[26] = {0};

    for (int i = 0; i < lettersSize; i++) {
        letterCount[letters[i] - 'a']++;
    }

    for (int i = 0; i < wordsSize; i++) {
        int wordCount[26] = {0};
        int valid = 1;

        for (int j = 0; words[i][j] != '\0'; j++) {
            wordCount[words[i][j] - 'a']++;
            if (wordCount[words[i][j] - 'a'] > letterCount[words[i][j] - 'a'] + 1) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            count++;
        }
    }

    return count;
}