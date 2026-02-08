char **splitString(char * s, char separator, int* returnSize) {
    int len = strlen(s);
    char **result = malloc(len * sizeof(char *));
    int count = 0;
    char *token = strtok(s, &separator);

    while (token != NULL) {
        result[count++] = strdup(token);
        token = strtok(NULL, &separator);
    }

    *returnSize = count;
    return result;
}