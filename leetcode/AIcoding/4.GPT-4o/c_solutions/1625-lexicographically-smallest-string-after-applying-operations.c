char* smallestString(char* s, int n) {
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            break;
        }
        s[i] = (s[i] == 'z') ? 'a' : s[i] + 1;
    }
    return s;
}