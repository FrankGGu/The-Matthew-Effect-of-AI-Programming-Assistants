#include <stdbool.h>
#include <stdlib.h>

int* markElements(int* arr, int arrSize, int** queries, int queriesSize, int* returnSize) {
    bool* marked = (bool*)calloc(arrSize, sizeof(bool));
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < arrSize; i++) {
        marked[i] = false;
    }

    for (int i = 0; i < queriesSize; i++) {
        int x = queries[i][0];
        for (int j = 0; j < arrSize; j++) {
            if (arr[j] == x) {
                marked[j] = true;
            }
        }
        int count = 0;
        for (int j = 0; j < arrSize; j++) {
            if (marked[j]) {
                count++;
            }
        }
        result[i] = count;
    }

    free(marked);
    return result;
}