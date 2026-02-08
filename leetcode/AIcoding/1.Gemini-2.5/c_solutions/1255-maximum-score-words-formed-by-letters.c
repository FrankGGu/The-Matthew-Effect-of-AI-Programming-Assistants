int solve(char **words, int wordsSize, int *letterCounts, int *scores, int index) {
    if (index == wordsSize) {
        return 0;
    }

    int scoreWithoutCurrentWord = solve(words, wordsSize, letterCounts, scores, index + 1);

    int currentWordScore = 0;
    int tempLetterCountsForWord[26] = {0};
    int canForm = 1;

    for (int i = 0; words[index][i] != '\0'; ++i) {
        char c = words[index][i];
        tempLetterCountsForWord[c - 'a']++;
        currentWordScore += scores[c - 'a'];
    }

    for (int i = 0; i < 26; ++i) {
        if (letterCounts[i] < tempLetterCountsForWord[i]) {
            canForm = 0;
            break;
        }
    }

    int scoreWithCurrentWord = 0;
    if (canForm) {
        for (int i = 0; i < 26; ++i) {
            letterCounts[i] -= tempLetterCountsForWord[i];
        }

        scoreWithCurrentWord = currentWordScore + solve(words, wordsSize, letterCounts, scores, index + 1);

        for (int i = 0; i < 26; ++i) {
            letterCounts[i] += tempLetterCountsForWord[i];
        }
    }

    return (scoreWithoutCurrentWord > scoreWithCurrentWord) ? scoreWithoutCurrentWord : scoreWithCurrentWord;
}

int maxScoreWords(char **words, int wordsSize, char *letters, int lettersSize, int *score) {
    int letterCounts[26] = {0};
    for (int i = 0; i < lettersSize; ++i) {
        letterCounts[letters[i] - 'a']++;
    }

    return solve(words, wordsSize, letterCounts, score, 0);
}