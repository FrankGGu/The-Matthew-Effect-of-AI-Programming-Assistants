int checkDistance(char *s, int distance) {
    int last[26];
    for (int i = 0; i < 26; i++) last[i] = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        if (last[index] != -1) {
            if (i - last[index] - 1 != distance) {
                return 0;
            }
        }
        last[index] = i;
    }
    return 1;
}