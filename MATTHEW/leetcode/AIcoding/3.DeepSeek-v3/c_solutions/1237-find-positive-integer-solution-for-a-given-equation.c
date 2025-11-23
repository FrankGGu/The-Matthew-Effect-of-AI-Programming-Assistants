/**
 * *********************************************************************
 * // This is the definition for the customFunction API.
 * // You should not implement it, or speculate about its implementation
 * *********************************************************************
 *
 * // Returns f(x, y) for any given positive integers x and y.
 * // Note that f(x, y) is increasing with respect to both x and y.
 * // i.e. f(x, y) < f(x + 1, y), f(x, y) < f(x, y + 1)
 * 
 * int customFunction(int x, int y);
 */

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** findSolution(int (*customFunction)(int, int), int z, int* returnSize, int** returnColumnSizes) {
    int** result = malloc(1000 * sizeof(int*));
    *returnColumnSizes = malloc(1000 * sizeof(int));
    *returnSize = 0;

    int x = 1, y = 1000;
    while (x <= 1000 && y >= 1) {
        int val = customFunction(x, y);
        if (val == z) {
            result[*returnSize] = malloc(2 * sizeof(int));
            result[*returnSize][0] = x;
            result[*returnSize][1] = y;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
            x++;
            y--;
        } else if (val < z) {
            x++;
        } else {
            y--;
        }
    }

    return result;
}