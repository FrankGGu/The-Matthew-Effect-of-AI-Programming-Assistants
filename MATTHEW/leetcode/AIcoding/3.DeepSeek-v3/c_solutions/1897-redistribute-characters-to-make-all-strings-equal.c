bool makeEqual(char** words, int wordsSize) {
    int count[26] = {0};
    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        for (int j = 0; word[j] != '\0'; j++) {
            count[word[j] - 'a']++;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (count[i] % wordsSize != 0) {
            return false;
        }
    }
    return true;
}