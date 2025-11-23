bool canConvertString(char *s, char *t, int k) {
    if (strcmp(s, t) == 0) return true;
    int count[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        int diff = (t[i] - s[i] + 26) % 26;
        if (diff > 0) {
            if (diff + 26 * count[diff] > k) return false;
            count[diff]++;
        }
    }
    return true;
}