int minimumScore(char* s, char* t) {
    int n = strlen(s);
    int m = strlen(t);

    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    int* suffix = (int*)malloc((n + 1) * sizeof(int));

    prefix[0] = 0;
    int j = 0;
    for (int i = 0; i < n; i++) {
        if (j < m && s[i] == t[j]) {
            j++;
        }
        prefix[i + 1] = j;
    }

    suffix[n] = 0;
    j = 0;
    for (int i = n - 1; i >= 0; i--) {
        if (j < m && s[i] == t[m - 1 - j]) {
            j++;
        }
        suffix[i] = j;
    }

    int min_score = m;
    for (int i = 0; i <= n; i++) {
        int matched = prefix[i] + suffix[i];
        if (matched >= m) {
            min_score = fmin(min_score, m - prefix[i]);
        } else {
            min_score = fmin(min_score, m - matched);
        }
    }

    free(prefix);
    free(suffix);
    return min_score;
}