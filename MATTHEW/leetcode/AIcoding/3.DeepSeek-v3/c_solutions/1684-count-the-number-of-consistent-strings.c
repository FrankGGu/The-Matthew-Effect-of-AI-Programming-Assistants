int countConsistentStrings(char * allowed, char ** words, int wordsSize){
    int allowedSet[26] = {0};
    for (int i = 0; allowed[i]; i++) {
        allowedSet[allowed[i] - 'a'] = 1;
    }

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int consistent = 1;
        for (int j = 0; word[j]; j++) {
            if (!allowedSet[word[j] - 'a']) {
                consistent = 0;
                break;
            }
        }
        if (consistent) {
            count++;
        }
    }
    return count;
}