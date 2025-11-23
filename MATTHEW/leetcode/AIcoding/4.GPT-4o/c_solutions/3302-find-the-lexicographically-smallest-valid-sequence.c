char * findLexSmallestString(char * s, int a, int b) {
    int n = strlen(s);
    char *result = strdup(s);
    for (int i = 0; i < n; i++) {
        char temp[n + 1];
        strcpy(temp, s);
        for (int j = 0; j < n; j++) {
            temp[(i + j * b) % n] = (temp[(i + j * b) % n] - '0' + a) % 10 + '0';
            if (strcmp(temp, result) < 0) {
                strcpy(result, temp);
            }
        }
    }
    return result;
}