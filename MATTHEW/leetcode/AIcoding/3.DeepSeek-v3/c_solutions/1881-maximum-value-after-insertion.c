int maximumValue(char** strs, int strsSize) {
    int max = 0;
    for (int i = 0; i < strsSize; i++) {
        char* s = strs[i];
        int value = 0;
        int hasAlpha = 0;

        for (int j = 0; s[j] != '\0'; j++) {
            if (s[j] >= 'a' && s[j] <= 'z') {
                hasAlpha = 1;
                break;
            }
        }

        if (hasAlpha) {
            value = strlen(s);
        } else {
            value = atoi(s);
        }

        if (value > max) {
            max = value;
        }
    }
    return max;
}