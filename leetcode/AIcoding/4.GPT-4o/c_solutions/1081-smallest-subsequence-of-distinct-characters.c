char * smallestSubsequence(char * s) {
    int last[256] = {0};
    int inStack[256] = {0};
    int len = strlen(s);
    char *result = (char *)malloc(len + 1);
    int index = 0;

    for (int i = 0; i < len; i++) {
        last[s[i]] = i;
    }

    for (int i = 0; i < len; i++) {
        if (inStack[s[i]]) continue;
        while (index > 0 && result[index - 1] > s[i] && last[result[index - 1]] > i) {
            inStack[result[index - 1]] = 0;
            index--;
        }
        result[index++] = s[i];
        inStack[s[i]] = 1;
    }

    result[index] = '\0';
    return result;
}