int countWords(char ** words, int wordsSize, char * prefix) {
    int count = 0;
    int prefixLen = strlen(prefix);

    for (int i = 0; i < wordsSize; i++) {
        if (strncmp(words[i], prefix, prefixLen) == 0) {
            count++;
        }
    }

    return count;
}