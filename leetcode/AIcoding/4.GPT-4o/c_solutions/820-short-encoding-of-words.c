int minimumLengthEncoding(char **words, int wordsSize) {
    // Create a set to store unique words
    int seen[2000] = {0};
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        for (int j = 0; j < len; j++) {
            seen[(int)words[i][j]] = 1;
        }
    }

    int totalLength = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        if (seen[(int)words[i][len - 1]]) {
            totalLength += len + 1; // +1 for the '#' symbol
            for (int j = 0; j < len; j++) {
                seen[(int)words[i][j]] = 0; // Mark this word as used
            }
        }
    }

    return totalLength;
}