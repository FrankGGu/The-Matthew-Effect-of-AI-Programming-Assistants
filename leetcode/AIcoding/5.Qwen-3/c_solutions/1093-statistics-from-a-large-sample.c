#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double* sampleStats(int* count, int countSize, int* data, int dataSize, int* returnSize) {
    double* result = (double*)malloc(5 * sizeof(double));
    *returnSize = 5;

    double mean = 0.0;
    double median = 0.0;
    double mode = 0.0;
    int maxCount = 0;

    int total = 0;
    for (int i = 0; i < countSize; i++) {
        total += count[i];
    }

    int* temp = (int*)malloc(total * sizeof(int));
    int index = 0;
    for (int i = 0; i < countSize; i++) {
        for (int j = 0; j < count[i]; j++) {
            temp[index++] = data[i];
        }
    }

    for (int i = 0; i < total; i++) {
        mean += temp[i];
    }
    mean /= total;

    for (int i = 0; i < countSize; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
            mode = data[i];
        }
    }

    qsort(temp, total, sizeof(int), (int(*)(const void*, const void*))strcmp);

    if (total % 2 == 1) {
        median = temp[total / 2];
    } else {
        median = (temp[(total / 2) - 1] + temp[total / 2]) / 2.0;
    }

    result[0] = mean;
    result[1] = median;
    result[2] = mode;
    result[3] = (double)*data;
    result[4] = (double)data[countSize - 1];

    free(temp);
    return result;
}