int minFlips(char *s) {
    int n = strlen(s);
    char *s1 = (char *)malloc(2 * n + 1);
    char *s2 = (char *)malloc(2 * n + 1);
    for (int i = 0; i < n; i++) {
        s1[i] = (i % 2 == 0) ? '0' : '1';
        s2[i] = (i % 2 == 0) ? '1' : '0';
    }
    s1[n] = s2[n] = '\0';
    for (int i = n; i < 2 * n; i++) {
        s1[i] = s1[i - n];
        s2[i] = s2[i - n];
    }

    int flip1 = 0, flip2 = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] != s1[i]) flip1++;
        if (s[i] != s2[i]) flip2++;
    }

    int minFlips = flip1 < flip2 ? flip1 : flip2;
    free(s1);
    free(s2);
    return minFlips;
}