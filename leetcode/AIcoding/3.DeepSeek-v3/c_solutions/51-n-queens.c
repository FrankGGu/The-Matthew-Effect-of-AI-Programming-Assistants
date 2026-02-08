/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
char*** solveNQueens(int n, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (n == 0) return NULL;

    int size = 0;
    int* queens = (int*)malloc(n * sizeof(int));
    char*** result = NULL;

    void backtrack(int row) {
        if (row == n) {
            char** solution = (char**)malloc(n * sizeof(char*));
            for (int i = 0; i < n; i++) {
                solution[i] = (char*)malloc((n + 1) * sizeof(char));
                for (int j = 0; j < n; j++) {
                    solution[i][j] = (queens[i] == j) ? 'Q' : '.';
                }
                solution[i][n] = '\0';
            }

            result = (char***)realloc(result, (size + 1) * sizeof(char**));
            result[size] = solution;
            size++;
            return;
        }

        for (int col = 0; col < n; col++) {
            int valid = 1;
            for (int i = 0; i < row; i++) {
                if (queens[i] == col || queens[i] - i == col - row || queens[i] + i == col + row) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                queens[row] = col;
                backtrack(row + 1);
            }
        }
    }

    backtrack(0);

    *returnSize = size;
    *returnColumnSizes = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        (*returnColumnSizes)[i] = n;
    }

    free(queens);
    return result;
}