/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    int total = 1;
    for (int i = 1; i <= k; i++) {
        total = total * (n - i + 1) / i;
    }

    int** result = (int**)malloc(total * sizeof(int*));
    *returnColumnSizes = (int*)malloc(total * sizeof(int));
    *returnSize = 0;

    int* current = (int*)malloc(k * sizeof(int));

    void backtrack(int start, int depth) {
        if (depth == k) {
            result[*returnSize] = (int*)malloc(k * sizeof(int));
            for (int i = 0; i < k; i++) {
                result[*returnSize][i] = current[i];
            }
            (*returnColumnSizes)[*returnSize] = k;
            (*returnSize)++;
            return;
        }

        for (int i = start; i <= n; i++) {
            current[depth] = i;
            backtrack(i + 1, depth + 1);
        }
    }

    backtrack(1, 0);
    free(current);
    return result;
}