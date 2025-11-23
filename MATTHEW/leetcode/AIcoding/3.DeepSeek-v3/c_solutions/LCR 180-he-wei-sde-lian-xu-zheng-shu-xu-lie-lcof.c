/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** fileCombination(int target, int* returnSize, int** returnColumnSizes) {
    int left = 1, right = 2;
    int sum = 3;
    int maxSize = target / 2 + 1;
    int** result = (int**)malloc(sizeof(int*) * maxSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * maxSize);
    *returnSize = 0;

    while (left < right) {
        if (sum == target) {
            int len = right - left + 1;
            result[*returnSize] = (int*)malloc(sizeof(int) * len);
            (*returnColumnSizes)[*returnSize] = len;
            for (int i = 0; i < len; i++) {
                result[*returnSize][i] = left + i;
            }
            (*returnSize)++;
            sum -= left;
            left++;
        } else if (sum < target) {
            right++;
            sum += right;
        } else {
            sum -= left;
            left++;
        }
    }

    return result;
}