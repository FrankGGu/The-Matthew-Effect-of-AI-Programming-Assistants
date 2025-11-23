int isAlienSorted(char** words, int wordsSize, char* order) {
    int map[26];
    for (int i = 0; i < 26; i++) {
        map[order[i] - 'a'] = i;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char* word1 = words[i];
        char* word2 = words[i + 1];

        while (*word1 && *word2 && *word1 == *word2) {
            word1++;
            word2++;
        }

        if (*word1 && !*word2) {
            return 0;
        }

        if (*word1 && *word2 && map[*word1 - 'a'] > map[*word2 - 'a']) {
            return 0;
        }
    }

    return 1;
}