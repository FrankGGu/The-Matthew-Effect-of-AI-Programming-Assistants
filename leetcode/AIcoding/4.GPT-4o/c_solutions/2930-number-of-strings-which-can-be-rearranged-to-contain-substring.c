int canBeRearranged(char *s, char *t) {
    int count[26] = {0};
    int t_count[26] = {0};

    for (int i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }

    for (int j = 0; t[j]; j++) {
        t_count[t[j] - 'a']++;
    }

    for (int k = 0; k < 26; k++) {
        if (t_count[k] > count[k]) {
            return 0;
        }
    }

    return 1;
}