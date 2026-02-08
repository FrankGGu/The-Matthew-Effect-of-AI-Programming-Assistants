int isAlienSorted(char** words, int wordsSize, char* order) {
    int map[26];
    for (int i = 0; i < 26; i++) {
        map[order[i] - 'a'] = i;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char* word1 = words[i];
        char* word2 = words[i + 1];
        int len1 = strlen(word1);
        int len2 = strlen(word2);
        int minLen = len1 < len2 ? len1 : len2;

        int j;
        for (j = 0; j < minLen; j++) {
            if (map[word1[j] - 'a'] < map[word2[j] - 'a']) {
                break;
            } else if (map[word1[j] - 'a'] > map[word2[j] - 'a']) {
                return 0;
            }
        }

        if (j == minLen && len1 > len2) {
            return 0;
        }
    }

    return 1;
}