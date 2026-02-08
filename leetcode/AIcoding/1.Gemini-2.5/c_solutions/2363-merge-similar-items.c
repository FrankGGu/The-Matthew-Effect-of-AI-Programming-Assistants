#include <stdlib.h>
#include <string.h>

int** mergeSimilarItems(int** items1, int items1Size, int* items1ColSize,
                         int** items2, int items2Size, int* items2ColSize,
                         int* returnSize, int** returnColumnSizes) {

    int weights_map[1001];
    memset(weights_map, 0, sizeof(weights_map));

    for (int i = 0; i < items1Size; ++i) {
        weights_map[items1[i][0]] += items1[i][1];
    }

    for (int i = 0; i < items2Size; ++i) {
        weights_map[items2[i][0]] += items2[i][1];
    }

    int count = 0;
    for (int i = 1; i <= 1000; ++i) {
        if (weights_map[i] > 0) {
            count++;
        }
    }

    *returnSize = count;

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));

    int current_idx = 0;
    for (int i = 1; i <= 1000; ++i) {
        if (weights_map[i] > 0) {
            result[current_idx] = (int*)malloc(2 * sizeof(int));
            result[current_idx][0] = i;
            result[current_idx][1] = weights_map[i];
            (*returnColumnSizes)[current_idx] = 2;
            current_idx++;
        }
    }

    return result;
}