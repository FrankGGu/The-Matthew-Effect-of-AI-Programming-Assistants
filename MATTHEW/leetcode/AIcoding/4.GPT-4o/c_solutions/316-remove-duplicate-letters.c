char *removeDuplicateLetters(char *s) {
    int lastIndex[26] = {0}, seen[26] = {0};
    int len = strlen(s);
    char *result = malloc(len + 1);
    int resultIndex = 0;

    for (int i = 0; i < len; i++) {
        lastIndex[s[i] - 'a'] = i;
    }

    for (int i = 0; i < len; i++) {
        int currentIndex = s[i] - 'a';
        if (seen[currentIndex]) continue;
        while (resultIndex > 0 && result[resultIndex - 1] > s[i] && lastIndex[result[resultIndex - 1] - 'a'] > i) {
            seen[result[--resultIndex] - 'a'] = 0;
        }
        result[resultIndex++] = s[i];
        seen[currentIndex] = 1;
    }

    result[resultIndex] = '\0';
    return result;
}