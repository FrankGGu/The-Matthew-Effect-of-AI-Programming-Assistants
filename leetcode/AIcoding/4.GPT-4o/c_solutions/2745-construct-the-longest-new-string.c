char* longestNewString(char* s) {
    int count[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc(2 * strlen(s) + 1);
    int len = 0;

    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            result[len++] = 'a' + i;
            count[i]--;
        }
    }

    for (int i = 0; i < 26; i++) {
        while (count[i] > 0) {
            result[len++] = 'a' + i;
            count[i]--;
        }
    }

    result[len] = '\0';
    return result;
}