int minimumTimeToChange(char *s, int time) {
    int n = strlen(s);
    int total_time = 0;
    int max_time = 0;

    for (int i = 0; i < n; i++) {
        if (i > 0 && s[i] == s[i - 1]) {
            total_time += time;
            max_time = max(max_time, time);
        } else {
            total_time += time;
        }
    }

    return total_time - max_time;
}