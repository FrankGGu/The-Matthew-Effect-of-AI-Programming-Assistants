/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** merge(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < intervalsSize - 1; i++) {
        for (int j = 0; j < intervalsSize - i - 1; j++) {
            if (intervals[j][0] > intervals[j + 1][0]) {
                int* temp = intervals[j];
                intervals[j] = intervals[j + 1];
                intervals[j + 1] = temp;
            }
        }
    }

    int** result = (int**)malloc(intervalsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(intervalsSize * sizeof(int));
    int count = 0;

    result[count] = (int*)malloc(2 * sizeof(int));
    result[count][0] = intervals[0][0];
    result[count][1] = intervals[0][1];
    (*returnColumnSizes)[count] = 2;
    count++;

    for (int i = 1; i < intervalsSize; i++) {
        int lastEnd = result[count - 1][1];

        if (intervals[i][0] <= lastEnd) {
            if (intervals[i][1] > lastEnd) {
                result[count - 1][1] = intervals[i][1];
            }
        } else {
            result[count] = (int*)malloc(2 * sizeof(int));
            result[count][0] = intervals[i][0];
            result[count][1] = intervals[i][1];
            (*returnColumnSizes)[count] = 2;
            count++;
        }
    }

    *returnSize = count;
    return result;
}