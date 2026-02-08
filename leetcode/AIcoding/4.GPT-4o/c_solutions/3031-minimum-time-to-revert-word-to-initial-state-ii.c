int minimumTime(char *s) {
    int n = strlen(s);
    int time = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'A') {
            time += 2;
        } else if (s[i] == 'B') {
            time += 3;
        } else {
            time += 1;
        }
    }

    return time;
}