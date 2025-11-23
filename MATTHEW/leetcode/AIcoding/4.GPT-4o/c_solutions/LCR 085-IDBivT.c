char** generateParenthesis(int n, int* returnSize) {
    char** result = malloc(10000 * sizeof(char*));
    *returnSize = 0;
    void backtrack(char* current, int open, int close, int n) {
        if (open == n && close == n) {
            result[(*returnSize)++] = strdup(current);
            return;
        }
        if (open < n) {
            current[strlen(current)] = '(';
            backtrack(current, open + 1, close, n);
            current[strlen(current) - 1] = '\0';
        }
        if (close < open) {
            current[strlen(current)] = ')';
            backtrack(current, open, close + 1, n);
            current[strlen(current) - 1] = '\0';
        }
    }
    char* current = malloc(2 * n + 1);
    current[0] = '\0';
    backtrack(current, 0, 0, n);
    free(current);
    return result;
}