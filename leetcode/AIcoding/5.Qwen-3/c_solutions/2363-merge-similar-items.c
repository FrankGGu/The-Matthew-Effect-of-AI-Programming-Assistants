#include <stdio.h>
#include <stdlib.h>

int** mergeSimilarItems(int** items, int itemsSize, int* itemsColSize, int* returnSize, int** returnColumnSizes) {
    int maxValue = 0;
    for (int i = 0; i < itemsSize; i++) {
        if (items[i][0] > maxValue) {
            maxValue = items[i][0];
        }
    }

    int* freq = (int*)calloc(maxValue + 1, sizeof(int));
    for (int i = 0; i < itemsSize; i++) {
        freq[items[i][0]] += items[i][1];
    }

    int count = 0;
    for (int i = 0; i <= maxValue; i++) {
        if (freq[i] > 0) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 0; i <= maxValue; i++) {
        if (freq[i] > 0) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = i;
            result[index][1] = freq[i];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    free(freq);
    return result;
}