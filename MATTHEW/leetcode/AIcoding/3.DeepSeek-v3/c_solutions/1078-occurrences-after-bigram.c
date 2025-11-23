/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** findOcurrences(char * text, char * first, char * second, int* returnSize){
    char **result = (char **)malloc(100 * sizeof(char *));
    *returnSize = 0;

    char *token = strtok(text, " ");
    char *prev1 = NULL;
    char *prev2 = NULL;

    while (token != NULL) {
        if (prev1 != NULL && prev2 != NULL) {
            if (strcmp(prev1, first) == 0 && strcmp(prev2, second) == 0) {
                result[*returnSize] = (char *)malloc((strlen(token) + 1) * sizeof(char));
                strcpy(result[*returnSize], token);
                (*returnSize)++;
            }
        }

        prev1 = prev2;
        prev2 = token;
        token = strtok(NULL, " ");
    }

    return result;
}