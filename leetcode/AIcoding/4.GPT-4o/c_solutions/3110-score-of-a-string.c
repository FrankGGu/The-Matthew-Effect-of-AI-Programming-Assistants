int scoreOfParentheses(char * s) {
    int score = 0, balance = 0;
    for (char *p = s; *p; p++) {
        if (*p == '(') {
            balance++;
        } else {
            balance--;
            if (*(p - 1) == '(') {
                score += 1 << balance;
            }
        }
    }
    return score;
}