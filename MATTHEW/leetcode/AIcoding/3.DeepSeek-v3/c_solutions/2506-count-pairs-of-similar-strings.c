int similarPairs(char** words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int set_i[26] = {0};
        for (int k = 0; words[i][k] != '\0'; k++) {
            set_i[words[i][k] - 'a'] = 1;
        }
        for (int j = i + 1; j < wordsSize; j++) {
            int set_j[26] = {0};
            for (int k = 0; words[j][k] != '\0'; k++) {
                set_j[words[j][k] - 'a'] = 1;
            }
            int similar = 1;
            for (int k = 0; k < 26; k++) {
                if (set_i[k] != set_j[k]) {
                    similar = 0;
                    break;
                }
            }
            if (similar) {
                count++;
            }
        }
    }
    return count;
}