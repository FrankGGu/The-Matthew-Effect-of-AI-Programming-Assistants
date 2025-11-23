/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
void backtrack(char* current, int pos, int n, char** result, int* count) {
    if (pos == n) {
        current[pos] = '\0';
        result[*count] = (char*)malloc((n + 1) * sizeof(char));
        strcpy(result[*count], current);
        (*count)++;
        return;
    }

    current[pos] = '1';
    backtrack(current, pos + 1, n, result, count);

    if (pos == 0 || current[pos - 1] != '0') {
        current[pos] = '0';
        backtrack(current, pos + 1, n, result, count);
    }
}

char** generateBinaryStrings(int n, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    int max_size = 1 << n;
    char** result = (char**)malloc(max_size * sizeof(char*));
    char* current = (char*)malloc((n + 1) * sizeof(char));
    *returnSize = 0;

    backtrack(current, 0, n, result, returnSize);

    free(current);
    return result;
}