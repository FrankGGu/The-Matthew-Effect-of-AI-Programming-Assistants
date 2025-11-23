char * smallestString(char * s) {
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] > 'a') {
            s[i] = 'a';
            break;
        }
    }
    return s;
}