#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *kthDistinct(char **arr, int arrSize, int k) {
    int *counts = (int *)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        counts[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            if (strcmp(arr[i], arr[j]) == 0) {
                counts[i]++;
            }
        }
    }

    int distinct_count = 0;
    for (int i = 0; i < arrSize; i++) {
        if (counts[i] == 1) {
            distinct_count++;
            if (distinct_count == k) {
                char *result = (char *)malloc((strlen(arr[i]) + 1) * sizeof(char));
                strcpy(result, arr[i]);
                free(counts);
                return result;
            }
        }
    }

    free(counts);
    return "";
}