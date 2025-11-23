bool isNumber(char * s) {
    char *p = s;
    while (*p == ' ') p++;
    if (*p == '\0') return false;

    bool numSeen = false, dotSeen = false, expSeen = false;
    if (*p == '+' || *p == '-') p++;

    while (*p) {
        if (*p >= '0' && *p <= '9') {
            numSeen = true;
        } else if (*p == '.') {
            if (dotSeen || expSeen) return false;
            dotSeen = true;
        } else if (*p == 'e' || *p == 'E') {
            if (expSeen || !numSeen) return false;
            expSeen = true;
            p++;
            if (*p == '+' || *p == '-') p++;
            if (*p < '0' || *p > '9') return false;
            continue;
        } else {
            return false;
        }
        p++;
    }

    while (*--p == ' ');
    return numSeen && (p >= s ? *p != ' ' : true);
}