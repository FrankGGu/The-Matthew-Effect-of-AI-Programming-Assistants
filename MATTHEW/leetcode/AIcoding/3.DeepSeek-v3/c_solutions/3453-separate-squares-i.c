/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* separateSquares(int n, int* returnSize) {
    *returnSize = 0;
    if (n == 0) {
        return NULL;
    }

    int* result = (int*)malloc(n * sizeof(int));
    if (!result) {
        return NULL;
    }

    int left = 0, right = n - 1;
    int leftSquare = 0, rightSquare = (n - 1) * (n - 1);

    for (int i = n - 1; i >= 0; i--) {
        if (leftSquare >= rightSquare) {
            result[i] = leftSquare;
            left++;
            leftSquare = left * left;
        } else {
            result[i] = rightSquare;
            right--;
            rightSquare = right * right;
        }
    }

    *returnSize = n;
    return result;
}