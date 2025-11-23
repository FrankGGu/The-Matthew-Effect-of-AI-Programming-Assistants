char* modifyString(char* s) {
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '?') {
            for (char c = 'a'; c <= 'c'; c++) {
                if ((i == 0 || s[i-1] != c) && (i == n-1 || s[i+1] != c)) {
                    s[i] = c;
                    break;
                }
            }
        }
    }
    return s;
}