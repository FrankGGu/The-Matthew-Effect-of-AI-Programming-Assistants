/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** mergeSimilarItems(int** items1, int items1Size, int* items1ColSize, int** items2, int items2Size, int* items2ColSize, int* returnSize, int** returnColumnSizes) {
    int map[1001] = {0};

    for (int i = 0; i < items1Size; i++) {
        map[items1[i][0]] += items1[i][1];
    }

    for (int i = 0; i < items2Size; i++) {
        map[items2[i][0]] += items2[i][1];
    }

    int count = 0;
    for (int i = 1; i <= 1000; i++) {
        if (map[i] > 0) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));

    int index = 0;
    for (int i = 1; i <= 1000; i++) {
        if (map[i] > 0) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = i;
            result[index][1] = map[i];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    *returnSize = count;
    return result;
}