bool isTransformable(char *s, char *t) {
    int count[10] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i] - '0']++;
        count[t[i] - '0']--;
    }
    for (int i = 0; i < 10; i++) {
        if (count[i] != 0) return false;
    }

    for (int i = 0; i < strlen(s); i++) {
        if (s[i] != t[i]) {
            for (int j = t[i] - '0' + 1; j < 10; j++) {
                if (count[j] > 0) return false;
            }
            count[s[i] - '0']--;
            count[t[i] - '0']++;
        }
    }

    return true;
}