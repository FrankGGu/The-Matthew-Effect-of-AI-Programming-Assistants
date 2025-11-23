int canBeEmpty(char *s) {
    int count = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == 'L') {
            count++;
        } else if (s[i] == 'R') {
            count--;
        }
    }
    return count == 0;
}