char* reverseWords(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc(len + 1);
    int i = len - 1, j = 0;

    while (i >= 0) {
        while (i >= 0 && s[i] == ' ') i--;
        if (i < 0) break;

        int end = i;
        while (i >= 0 && s[i] != ' ') i--;

        if (j > 0) result[j++] = ' ';
        for (int k = i + 1; k <= end; k++) {
            result[j++] = s[k];
        }
    }

    result[j] = '\0';
    return result;
}