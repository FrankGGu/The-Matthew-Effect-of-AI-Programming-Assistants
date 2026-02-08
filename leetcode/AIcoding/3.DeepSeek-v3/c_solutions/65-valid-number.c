bool isNumber(char* s) {
    int i = 0;
    while (s[i] == ' ') i++;

    if (s[i] == '+' || s[i] == '-') i++;

    int digits = 0, dots = 0;
    while (s[i] >= '0' && s[i] <= '9' || s[i] == '.') {
        if (s[i] == '.') dots++;
        else digits++;
        i++;
    }
    if (digits < 1 || dots > 1) return false;

    if (s[i] == 'e' || s[i] == 'E') {
        i++;
        if (s[i] == '+' || s[i] == '-') i++;

        digits = 0;
        while (s[i] >= '0' && s[i] <= '9') {
            digits++;
            i++;
        }
        if (digits < 1) return false;
    }

    while (s[i] == ' ') i++;

    return s[i] == '\0';
}