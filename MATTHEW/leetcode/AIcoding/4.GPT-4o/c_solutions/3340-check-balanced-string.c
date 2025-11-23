bool checkBalancedString(char *s) {
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            count++;
        } else if (s[i] == ')') {
            count--;
        }
    }
    return count == 0;
}