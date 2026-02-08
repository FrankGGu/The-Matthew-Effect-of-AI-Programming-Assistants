#include <stdlib.h>

static int global_median;

static int compare_ints(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

static int compare_strength(const void *a, const void *b) {
    int val1 = *(int*)a;
    int val2 = *(int*)b;

    int diff1 = abs(val1 - global_median);
    int diff2 = abs(val2 - global_median);

    // Sort in descending order of strength
    if (diff1 != diff2) {
        return diff2 - diff1;
    }
    // If strengths are equal, sort in descending order of value
    return val2 - val1;
}

int* getStrongest(int* arr, int arrSize, int k, int* returnSize) {
    // 1. Sort the array to find the median
    qsort(arr, arrSize, sizeof(int), compare_ints);

    // 2. Determine the median 'm'
    global_median = arr[(arrSize - 1) / 2];

    // 3. Sort the array again using the custom strength comparison
    qsort(arr, arrSize, sizeof(int), compare_strength);

    // 4. Allocate memory for the result and copy the first k elements
    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = arr[i];
    }

    *returnSize = k;
    return result;
}