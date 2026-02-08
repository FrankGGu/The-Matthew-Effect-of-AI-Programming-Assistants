int countConsistentStrings(char *allowed, char **words, int wordsSize) {
    int allowedSet[26] = {0};
    for (int i = 0; allowed[i] != '\0'; i++) {
        allowedSet[allowed[i] - 'a'] = 1;
    }

    int consistentCount = 0;
    for (int i = 0; i < wordsSize; i++) {
        int isConsistent = 1;
        for (int j = 0; words[i][j] != '\0'; j++) {
            if (!allowedSet[words[i][j] - 'a']) {
                isConsistent = 0;
                break;
            }
        }
        consistentCount += isConsistent;
    }

    return consistentCount;
}