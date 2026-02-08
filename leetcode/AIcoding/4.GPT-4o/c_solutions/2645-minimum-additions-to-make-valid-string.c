int minAddToMakeValid(char *s) {
    int balance = 0, additions = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            balance++;
        } else if (s[i] == ')') {
            if (balance > 0) {
                balance--;
            } else {
                additions++;
            }
        }
    }
    return additions + balance;
}