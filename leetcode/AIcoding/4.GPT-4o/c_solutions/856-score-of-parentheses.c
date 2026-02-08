int scoreOfParentheses(char * S) {
    int score = 0, balance = 0;
    for (int i = 0; S[i]; i++) {
        if (S[i] == '(') {
            balance++;
        } else {
            balance--;
            if (S[i - 1] == '(') {
                score += 1 << balance;
            }
        }
    }
    return score;
}