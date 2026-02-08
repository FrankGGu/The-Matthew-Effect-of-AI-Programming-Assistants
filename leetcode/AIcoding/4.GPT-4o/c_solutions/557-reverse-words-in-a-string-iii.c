char * reverseWords(char * s) {
    int length = strlen(s);
    char *result = (char *)malloc((length + 1) * sizeof(char));
    int start = 0, end = 0, index = 0;

    while (end <= length) {
        if (s[end] == ' ' || s[end] == '\0') {
            for (int i = end - 1; i >= start; i--) {
                result[index++] = s[i];
            }
            if (s[end] == ' ') {
                result[index++] = ' ';
            }
            start = end + 1;
        }
        end++;
    }
    result[index] = '\0';
    return result;
}