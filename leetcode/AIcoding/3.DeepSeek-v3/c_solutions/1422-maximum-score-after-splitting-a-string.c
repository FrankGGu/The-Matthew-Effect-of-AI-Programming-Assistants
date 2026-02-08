int maxScore(char* s) {
    int len = strlen(s);
    int totalOnes = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] == '1') totalOnes++;
    }

    int maxScore = 0;
    int leftZeros = 0;
    int rightOnes = totalOnes;

    for (int i = 0; i < len - 1; i++) {
        if (s[i] == '0') {
            leftZeros++;
        } else {
            rightOnes--;
        }
        int currentScore = leftZeros + rightOnes;
        if (currentScore > maxScore) {
            maxScore = currentScore;
        }
    }

    return maxScore;
}