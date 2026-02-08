int prefixCount(char** words, int wordsSize, char* pref) {
    int count = 0;
    int prefLen = strlen(pref);

    for (int i = 0; i < wordsSize; i++) {
        if (strlen(words[i]) >= prefLen && strncmp(words[i], pref, prefLen) == 0) {
            count++;
        }
    }

    return count;
}