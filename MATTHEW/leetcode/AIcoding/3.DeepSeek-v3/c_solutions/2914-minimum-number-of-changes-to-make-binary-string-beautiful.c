int minChanges(char* s) {
    int changes = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i += 2) {
        if (s[i] != s[i + 1]) {
            changes++;
        }
    }
    return changes;
}