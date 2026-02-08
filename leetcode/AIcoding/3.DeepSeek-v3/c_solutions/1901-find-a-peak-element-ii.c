/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findPeakGrid(int** mat, int matSize, int* matColSize, int* returnSize) {
    int m = matSize;
    int n = matColSize[0];
    int left = 0, right = n - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        int maxRow = 0;
        for (int i = 0; i < m; i++) {
            if (mat[i][mid] > mat[maxRow][mid]) {
                maxRow = i;
            }
        }

        bool leftIsBig = mid > 0 && mat[maxRow][mid - 1] > mat[maxRow][mid];
        bool rightIsBig = mid < n - 1 && mat[maxRow][mid + 1] > mat[maxRow][mid];

        if (!leftIsBig && !rightIsBig) {
            int* result = malloc(2 * sizeof(int));
            result[0] = maxRow;
            result[1] = mid;
            *returnSize = 2;
            return result;
        } else if (rightIsBig) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    int* result = malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;
    *returnSize = 2;
    return result;
}