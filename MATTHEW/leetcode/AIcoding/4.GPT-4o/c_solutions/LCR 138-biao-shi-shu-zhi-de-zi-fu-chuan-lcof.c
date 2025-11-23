bool isNumber(char * s) {
    int i = 0, n = strlen(s), state = 0, hasDot = 0, hasE = 0;

    while (i < n && s[i] == ' ') i++;
    if (i == n) return false;

    if (s[i] == '-' || s[i] == '+') i++;
    while (i < n && isdigit(s[i])) i++;

    if (i < n && s[i] == '.') {
        hasDot = 1;
        i++;
        while (i < n && isdigit(s[i])) i++;
    }

    if (i < n && (s[i] == 'e' || s[i] == 'E')) {
        hasE = 1;
        i++;
        if (s[i] == '-' || s[i] == '+') i++;
        if (i < n && !isdigit(s[i])) return false;
        while (i < n && isdigit(s[i])) i++;
    }

    while (i < n && s[i] == ' ') i++;
    return i == n && (hasDot || hasE || (i > 0 && (isdigit(s[i - 1]) || s[i - 1] == '.')));
}