char **findOcurrences(char *text, char *first, char *second, int *returnSize) {
    char **result = malloc(1000 * sizeof(char *));
    *returnSize = 0;
    char *token = strtok(text, " ");
    char *words[1000];
    int count = 0;

    while (token) {
        words[count++] = token;
        token = strtok(NULL, " ");
    }

    for (int i = 0; i < count - 2; i++) {
        if (strcmp(words[i], first) == 0 && strcmp(words[i + 1], second) == 0) {
            result[*returnSize] = words[i + 2];
            (*returnSize)++;
        }
    }

    return result;
}