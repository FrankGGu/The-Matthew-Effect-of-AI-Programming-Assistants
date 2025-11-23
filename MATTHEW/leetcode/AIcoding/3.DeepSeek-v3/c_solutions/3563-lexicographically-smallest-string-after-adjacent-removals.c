char* smallestString(char* s) {
    int n = strlen(s);
    int i = 0;
    while (i < n - 1) {
        if (s[i] > s[i + 1]) {
            for (int j = i; j < n - 1; j++) {
                s[j] = s[j + 1];
            }
            s[n - 1] = '\0';
            n--;
            if (i > 0) i--;
            continue;
        }
        i++;
    }
    s[n] = '\0';
    return s;
}