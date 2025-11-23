int maxScore(char * s) {
    int score = 0, maxScore = 0, n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') score++;
    }
    maxScore = score;
    for (int i = 0; i < n - 1; i++) {
        if (s[i] == '0') score--;
        else score++;
        if (score > maxScore) maxScore = score;
    }
    return maxScore;
}