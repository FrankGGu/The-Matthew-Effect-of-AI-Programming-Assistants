int countPrefixes(char** words, int wordsSize, char* s) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int j = 0;
        while (word[j] != '\0' && s[j] != '\0' && word[j] == s[j]) {
            j++;
        }
        if (word[j] == '\0') {
            count++;
        }
    }
    return count;
}