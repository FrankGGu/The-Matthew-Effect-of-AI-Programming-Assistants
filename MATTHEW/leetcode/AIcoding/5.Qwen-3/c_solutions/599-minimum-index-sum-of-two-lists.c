#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findRestaurant(char** list1, int list1Size, char** list2, int list2Size, int* returnSize) {
    int i, j;
    int minIndexSum = INT_MAX;
    int count = 0;
    char** result = NULL;

    // Create a hash map to store the index of each restaurant in list1
    int* indexMap = (int*)calloc(list1Size, sizeof(int));
    char** keys = (char**)malloc(list1Size * sizeof(char*));
    for (i = 0; i < list1Size; i++) {
        keys[i] = strdup(list1[i]);
        indexMap[i] = i;
    }

    // Iterate through list2 and check if the restaurant exists in list1
    for (i = 0; i < list2Size; i++) {
        for (j = 0; j < list1Size; j++) {
            if (strcmp(list2[i], keys[j]) == 0) {
                int sum = i + j;
                if (sum < minIndexSum) {
                    minIndexSum = sum;
                    count = 1;
                    result = (char**)realloc(result, sizeof(char*));
                    result[0] = strdup(list2[i]);
                } else if (sum == minIndexSum) {
                    count++;
                    result = (char**)realloc(result, count * sizeof(char*));
                    result[count - 1] = strdup(list2[i]);
                }
                break;
            }
        }
    }

    *returnSize = count;
    return result;
}