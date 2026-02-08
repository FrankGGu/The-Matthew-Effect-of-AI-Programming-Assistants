/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    int* arr1 = *(int**)a;
    int* arr2 = *(int**)b;
    if (arr1[0] == arr2[0]) {
        return arr1[1] - arr2[1];
    }
    return arr1[0] - arr2[0];
}

int** merge(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int** res = (int**)malloc(sizeof(int*) * intervalsSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * intervalsSize);
    *returnSize = 0;

    int start = intervals[0][0];
    int end = intervals[0][1];

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i][0] <= end) {
            if (intervals[i][1] > end) {
                end = intervals[i][1];
            }
        } else {
            res[*returnSize] = (int*)malloc(sizeof(int) * 2);
            res[*returnSize][0] = start;
            res[*returnSize][1] = end;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;

            start = intervals[i][0];
            end = intervals[i][1];
        }
    }

    res[*returnSize] = (int*)malloc(sizeof(int) * 2);
    res[*returnSize][0] = start;
    res[*returnSize][1] = end;
    (*returnColumnSizes)[*returnSize] = 2;
    (*returnSize)++;

    return res;
}