char *removeOccurrences(char *s, char *part) {
    int len_s = strlen(s);
    int len_part = strlen(part);
    char *result = (char *)malloc(len_s + 1);
    int index = 0;

    while (*s) {
        if (strncmp(s, part, len_part) == 0) {
            s += len_part;
        } else {
            result[index++] = *s++;
        }
    }
    result[index] = '\0';

    return result;
}