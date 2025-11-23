int maxScoreWords(char** words, int wordsSize, char* letters, int lettersSize, int* score, int scoreSize) {
    int freq[26] = {0};
    for (int i = 0; i < lettersSize; i++) {
        freq[letters[i] - 'a']++;
    }

    int n = wordsSize;
    int maxScore = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        int currentFreq[26] = {0};
        int valid = 1;
        int currentScore = 0;

        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                for (int j = 0; words[i][j] != '\0'; j++) {
                    int idx = words[i][j] - 'a';
                    currentFreq[idx]++;
                    currentScore += score[idx];
                    if (currentFreq[idx] > freq[idx]) {
                        valid = 0;
                        break;
                    }
                }
                if (!valid) break;
            }
        }

        if (valid && currentScore > maxScore) {
            maxScore = currentScore;
        }
    }

    return maxScore;
}