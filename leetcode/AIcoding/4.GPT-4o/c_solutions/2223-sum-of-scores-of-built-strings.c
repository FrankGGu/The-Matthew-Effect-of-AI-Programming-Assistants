int sumOfScores(char **words, int wordsSize) {
    int totalScore = 0;
    for (int i = 0; i < wordsSize; i++) {
        int score = 0, length = strlen(words[i]);
        for (int j = 0; j < length; j++) {
            if (j > 0 && words[i][j] == words[i][j - 1]) {
                score++;
            }
        }
        totalScore += score + length;
    }
    return totalScore;
}