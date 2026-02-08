#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Range;

int* solve(int n, int* queryType, int queryTypeSize, int* index, int indexSize, int* value, int valueSize, int* resultSize) {
    int* arr = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = 0;
    }

    int resultCapacity = 10000;
    int* result = (int*)malloc(resultCapacity * sizeof(int));
    *resultSize = 0;

    for (int i = 0; i < queryTypeSize; i++) {
        if (queryType[i] == 0) {
            arr[index[i]] = value[i];
        } else {
            int sum = 0;
            for (int j = index[i]; j <= value[i]; j++) {
                sum += arr[j];
            }
            result[(*resultSize)++] = sum;
        }
    }

    return result;
}