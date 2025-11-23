char *sortString(char *s) {
    int count[26] = {0};
    int len = strlen(s);
    char *result = malloc(len + 1);
    int index = 0;

    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    while (index < len) {
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                result[index++] = 'a' + i;
                count[i]--;
            }
        }
        for (int i = 25; i >= 0; i--) {
            if (count[i] > 0) {
                result[index++] = 'a' + i;
                count[i]--;
            }
        }
    }

    result[index] = '\0';
    return result;
}