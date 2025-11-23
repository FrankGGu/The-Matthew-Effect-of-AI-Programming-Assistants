int minLengthOfConcatenation(char **words, int wordsSize) {
    int count[26] = {0};
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; words[i][j] != '\0'; j++) {
            count[words[i][j] - 'a']++;
        }
    }
    int length = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 != 0) {
            length++;
        }
    }
    return length > 0 ? length * 2 - 1 : 0;
}