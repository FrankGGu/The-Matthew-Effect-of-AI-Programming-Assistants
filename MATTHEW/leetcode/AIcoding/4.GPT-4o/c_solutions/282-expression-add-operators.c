void backtrack(char *num, int target, int start, long long prev, long long curr, char *expr, int len, char ***results, int *returnSize) {
    if (start == strlen(num)) {
        if (curr == target) {
            expr[len] = '\0';
            (*results)[(*returnSize)++] = strdup(expr);
        }
        return;
    }

    for (int i = start; i < strlen(num); i++) {
        if (i != start && num[start] == '0') break;
        long long next = atoll(strndup(num + start, i - start + 1));
        char temp[20];
        sprintf(temp, "%lld", next);

        if (start == 0) {
            backtrack(num, target, i + 1, next, next, expr, len + strlen(temp), results, returnSize);
        } else {
            expr[len] = '+';
            strcpy(expr + len + 1, temp);
            backtrack(num, target, i + 1, next, curr + next, expr, len + 1 + strlen(temp), results, returnSize);
            expr[len] = '-';
            backtrack(num, target, i + 1, -next, curr - next, expr, len + 1 + strlen(temp), results, returnSize);
            expr[len] = '*';
            backtrack(num, target, i + 1, prev * next, curr - prev + (prev * next), expr, len + 1 + strlen(temp), results, returnSize);
        }
    }
}

char **addOperators(char *num, int target, int *returnSize) {
    *returnSize = 0;
    int capacity = 1000;
    char **results = (char **)malloc(capacity * sizeof(char *));
    char *expr = (char *)malloc((strlen(num) * 2) * sizeof(char));
    backtrack(num, target, 0, 0, 0, expr, 0, &results, returnSize);
    free(expr);
    return results;
}