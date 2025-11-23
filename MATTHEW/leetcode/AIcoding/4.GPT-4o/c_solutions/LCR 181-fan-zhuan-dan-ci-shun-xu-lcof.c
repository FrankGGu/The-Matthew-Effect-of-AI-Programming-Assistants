char * reverseWords(char * s) {
    int len = strlen(s);
    char *result = (char *)malloc((len + 1) * sizeof(char));
    int index = 0, end = len - 1;

    while (end >= 0) {
        while (end >= 0 && s[end] == ' ') end--;
        if (end < 0) break;
        int start = end;
        while (start >= 0 && s[start] != ' ') start--;
        start++;
        for (int i = start; i <= end; i++) {
            result[index++] = s[i];
        }
        result[index++] = ' ';
        end = start - 2;
    }

    if (index > 0) index--; // Remove the trailing space
    result[index] = '\0';

    return result;
}