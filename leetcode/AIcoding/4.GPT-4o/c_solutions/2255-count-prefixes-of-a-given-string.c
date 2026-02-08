int countPrefixes(char ** words, int wordsSize, char * s) {
    int count = 0;
    int sLen = strlen(s);
    for (int i = 0; i < wordsSize; i++) {
        if (strncmp(words[i], s, strlen(words[i])) == 0) {
            count++;
        }
    }
    return count;
}