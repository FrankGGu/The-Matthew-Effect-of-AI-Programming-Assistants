int countPairs(char ** words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordsSize; j++) {
            if (i != j) {
                int len1 = strlen(words[i]);
                int len2 = strlen(words[j]);
                if (len1 <= len2 && strncmp(words[i], words[j] + len2 - len1, len1) == 0) {
                    count++;
                }
            }
        }
    }
    return count;
}