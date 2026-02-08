int scoreOfString(char* s) {
    int score = 0;
    for (int i = 1; s[i] != '\0'; i++) {
        score += abs(s[i] - s[i-1]);
    }
    return score;
}