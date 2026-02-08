void backtrack(char** result, int* count, char* current, int open, int close, int max, int pos) {
    if (pos == max * 2) {
        current[pos] = '\0';
        result[*count] = (char*)malloc(sizeof(char) * (max * 2 + 1));
        strcpy(result[*count], current);
        (*count)++;
        return;
    }

    if (open < max) {
        current[pos] = '(';
        backtrack(result, count, current, open + 1, close, max, pos + 1);
    }

    if (close < open) {
        current[pos] = ')';
        backtrack(result, count, current, open, close + 1, max, pos + 1);
    }
}

char** generateParenthesis(int n, int* returnSize) {
    *returnSize = 0;
    int maxCombinations = 1;
    for (int i = 0; i < n; i++) {
        maxCombinations = maxCombinations * (2 * n - i) / (i + 1);
    }
    maxCombinations /= (n + 1);

    char** result = (char**)malloc(sizeof(char*) * maxCombinations);
    char* current = (char*)malloc(sizeof(char) * (2 * n + 1));

    backtrack(result, returnSize, current, 0, 0, n, 0);

    free(current);
    return result;
}