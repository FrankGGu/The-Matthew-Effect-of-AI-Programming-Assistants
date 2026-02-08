char * concatenateDecrementalString(char * s) {
    int n = strlen(s);
    char *result = (char *)malloc((n * (n + 1) / 2 + 1) * sizeof(char));
    int index = 0;

    for (int i = n; i > 0; i--) {
        strncpy(result + index, s, i);
        index += i;
    }

    result[index] = '\0';
    return result;
}