bool canWin(char* s) {
    for (int i = 0; s[i + 1] != '\0'; i++) {
        if (s[i] == '+' && s[i + 1] == '+' && (i == 0 || s[i - 1] != '+')) {
            s[i] = s[i + 1] = '-';
            if (!canWin(s)) {
                s[i] = s[i + 1] = '+';
                return true;
            }
            s[i] = s[i + 1] = '+';
        }
    }
    return false;
}