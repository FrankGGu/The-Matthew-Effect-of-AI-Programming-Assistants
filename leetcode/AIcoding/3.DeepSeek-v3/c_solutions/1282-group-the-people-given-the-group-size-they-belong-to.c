/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** groupThePeople(int* groupSizes, int groupSizesSize, int* returnSize, int** returnColumnSizes) {
    int** groups = (int**)malloc(groupSizesSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(groupSizesSize * sizeof(int));
    *returnSize = 0;

    int* groupCounts = (int*)calloc(groupSizesSize + 1, sizeof(int));
    int** groupLists = (int**)malloc((groupSizesSize + 1) * sizeof(int*));

    for (int i = 0; i <= groupSizesSize; i++) {
        groupLists[i] = (int*)malloc(groupSizesSize * sizeof(int));
        groupCounts[i] = 0;
    }

    for (int i = 0; i < groupSizesSize; i++) {
        int size = groupSizes[i];
        groupLists[size][groupCounts[size]++] = i;

        if (groupCounts[size] == size) {
            groups[*returnSize] = (int*)malloc(size * sizeof(int));
            (*returnColumnSizes)[*returnSize] = size;
            for (int j = 0; j < size; j++) {
                groups[*returnSize][j] = groupLists[size][j];
            }
            (*returnSize)++;
            groupCounts[size] = 0;
        }
    }

    for (int i = 0; i <= groupSizesSize; i++) {
        free(groupLists[i]);
    }
    free(groupLists);
    free(groupCounts);

    return groups;
}