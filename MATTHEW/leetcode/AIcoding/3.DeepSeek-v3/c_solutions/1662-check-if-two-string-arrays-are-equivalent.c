bool arrayStringsAreEqual(char** word1, int word1Size, char** word2, int word2Size) {
    int i = 0, j = 0;
    int idx1 = 0, idx2 = 0;

    while (i < word1Size && j < word2Size) {
        if (word1[i][idx1] != word2[j][idx2]) {
            return false;
        }

        idx1++;
        idx2++;

        if (word1[i][idx1] == '\0') {
            i++;
            idx1 = 0;
        }

        if (word2[j][idx2] == '\0') {
            j++;
            idx2 = 0;
        }
    }

    return i == word1Size && j == word2Size;
}