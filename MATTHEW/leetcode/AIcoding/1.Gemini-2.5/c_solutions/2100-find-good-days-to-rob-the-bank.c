#include <stdlib.h>

int* goodDaysToRobBank(int* security, int securitySize, int time, int* returnSize) {
    if (securitySize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // left[i] stores the number of consecutive non-increasing steps ending at index i.
    // A step is security[k-1] >= security[k].
    // If left[i] = k, it means security[i-k] >= ... >= security[i-1] >= security[i].
    // We need 'time' non-increasing steps before and including security[i-1] relative to i.
    // This means we need security[i-time] >= security[i-time+1] >= ... >= security[i-1] >= security[i].
    // This sequence has 'time' steps. So, left[i] must be >= time.
    int* left = (int*)malloc(securitySize * sizeof(int));
    if (left == NULL) {
        *returnSize = 0;
        return NULL;
    }
    left[0] = 0; 
    for (int i = 1; i < securitySize; i++) {
        if (security[i-1] >= security[i]) {
            left[i] = left[i-1] + 1;
        } else {
            left[i] = 0;
        }
    }

    // right[i] stores the number of consecutive non-decreasing steps starting at index i.
    // A step is security[k] <= security[k+1].
    // If right[i] = k, it means security[i] <= security[i+1] <= ... <= security[i+k].
    // We need 'time' non-decreasing steps starting at security[i] and including security[i+time].
    // This means we need security[i] <= security[i+1] <= ... <= security[i+time-1] <= security[i+time].
    // This sequence has 'time' steps. So, right[i] must be >= time.
    int* right = (int*)malloc(securitySize * sizeof(int));
    if (right == NULL) {
        free(left);
        *returnSize = 0;
        return NULL;
    }
    right[securitySize - 1] = 0;
    for (int i = securitySize - 2; i >= 0; i--) {
        if (security[i] <= security[i+1]) {
            right[i] = right[i+1] + 1;
        } else {
            right[i] = 0;
        }
    }

    int* result = (int*)malloc(securitySize * sizeof(int));
    if (result == NULL) {
        free(left);
        free(right);
        *returnSize = 0;
        return NULL;
    }
    int count = 0;
    for (int i = 0; i < securitySize; i++) {
        if (left[i] >= time && right[i] >= time) {
            result[count++] = i;
        }
    }

    free(left);
    free(right);

    *returnSize = count;
    // Reallocate the result array to its exact size.
    // If count is 0, realloc(result, 0) will free result and return NULL.
    return (int*)realloc(result, count * sizeof(int));
}