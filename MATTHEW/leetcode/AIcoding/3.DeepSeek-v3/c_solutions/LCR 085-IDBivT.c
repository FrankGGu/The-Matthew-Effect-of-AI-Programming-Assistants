/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
void backtrack(char** result, int* count, char* current, int open, int close, int max) {
    if (strlen(current) == max * 2) {
        result[*count] = (char*)malloc(sizeof(char) * (max * 2 + 1));
        strcpy(result[*count], current);
        (*count)++;
        return;
    }

    if (open < max) {
        current[open + close] = '(';
        backtrack(result, count, current, open + 1, close, max);
    }

    if (close < open) {
        current[open + close] = ')';
        backtrack(result, count, current, open, close + 1, max);
    }
}

char** generateParenthesis(int n, int* returnSize) {
    int max = n * 2;
    char* current = (char*)malloc(sizeof(char) * (max + 1));
    memset(current, 0, sizeof(char) * (max + 1));

    // Maximum possible combinations is the nth Catalan number
    int maxSize = 1;
    for (int i = 0; i < n; i++) {
        maxSize = maxSize * (2 * n - i) / (i + 1);
    }
    maxSize = maxSize / (n + 1);

    char** result = (char**)malloc(sizeof(char*) * maxSize);
    *returnSize = 0;

    backtrack(result, returnSize, current, 0, 0, n);

    free(current);
    return result;
}