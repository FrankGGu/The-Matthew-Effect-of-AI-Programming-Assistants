/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** largeGroupPositions(char* s, int* returnSize, int** returnColumnSizes) {
    int n = strlen(s);
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    int start = 0;
    for (int end = 0; end < n; end++) {
        if (end == n - 1 || s[end] != s[end + 1]) {
            if (end - start + 1 >= 3) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = start;
                result[*returnSize][1] = end;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
            start = end + 1;
        }
    }

    return result;
}