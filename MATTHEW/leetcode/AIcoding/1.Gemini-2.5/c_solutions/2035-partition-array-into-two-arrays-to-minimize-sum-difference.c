#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <math.h>

typedef struct {
    long long *arr;
    int size;
    int capacity;
} LongLongVector;

void initVector(LongLongVector *vec, int initialCapacity) {
    vec->arr = (long long *)malloc(sizeof(long long) * initialCapacity);
    vec->size = 0;
    vec->capacity = initialCapacity;
}

void addVector(LongLongVector *vec, long long val) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2;
        vec->arr = (long long *)realloc(vec->arr, sizeof(long long) * vec->capacity);
    }
    vec->arr[vec->size++] = val;
}

void freeVector(LongLongVector *vec) {
    free(vec->arr);
    vec->arr = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

int compareLongLong(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

void generateSubsetSums(int idx, int count, long long currentSum, int limit, int *nums, LongLongVector *resultByCount) {
    if (idx == limit) {
        addVector(&resultByCount[count], currentSum);
        return;
    }

    generateSubsetSums(idx + 1, count + 1, currentSum + nums[idx], limit, nums, resultByCount);
    generateSubsetSums(idx + 1, count, currentSum, limit, nums, resultByCount);
}

long long* lower_bound(long long* arr, int size, long long target) {
    int low = 0;
    int high = size;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return (low == size) ? NULL : &arr[low];
}

int minAbsDifference(int* nums, int numsSize) {
    int n = numsSize / 2;
    long long totalSum = 0;
    for (int i = 0; i < numsSize; ++i) {
        totalSum += nums[i];
    }

    LongLongVector *leftSumsByCount = (LongLongVector *)malloc(sizeof(LongLongVector) * (n + 1));
    LongLongVector *rightSumsByCount = (LongLongVector *)malloc(sizeof(LongLongVector) * (n + 1));

    for (int i = 0; i <= n; ++i) {
        initVector(&leftSumsByCount[i], 16);
        initVector(&rightSumsByCount[i], 16);
    }

    generateSubsetSums(0, 0, 0, n, nums, leftSumsByCount);
    generateSubsetSums(0, 0, 0, n, nums + n, rightSumsByCount);

    for (int i = 0; i <= n; ++i) {
        qsort(leftSumsByCount[i].arr, leftSumsByCount[i].size, sizeof(long long), compareLongLong);
        qsort(rightSumsByCount[i].arr, rightSumsByCount[i].size, sizeof(long long), compareLongLong);
    }

    long long minDiff = LLONG_MAX;

    for (int k = 0; k <= n; ++k) {
        LongLongVector *leftSums = &leftSumsByCount[k];
        LongLongVector *rightSums = &rightSumsByCount[n - k];

        for (int i = 0; i < leftSums->size; ++i) {
            long long s_left = leftSums->arr[i];
            long long target_right_sum = (totalSum - 2 * s_left) / 2;

            long long* it = lower_bound(rightSums->arr, rightSums->size, target_right_sum);

            if (it != NULL) {
                long long current_total_partition_sum = s_left + *it;
                long long diff = llabs(2 * current_total_partition_sum - totalSum);
                if (diff < minDiff) {
                    minDiff = diff;
                }
            }

            if (it != NULL && it != rightSums->arr) {
                long long s_right_prev = *(it - 1);
                long long current_total_partition_sum = s_left + s_right_prev;
                long long diff = llabs(2 * current_total_partition_sum - totalSum);
                if (diff < minDiff) {
                    minDiff = diff;
                }
            }
        }
    }

    for (int i = 0; i <= n; ++i) {
        freeVector(&leftSumsByCount[i]);
        freeVector(&rightSumsByCount[i]);
    }
    free(leftSumsByCount);
    free(rightSumsByCount);

    return (int)minDiff;
}