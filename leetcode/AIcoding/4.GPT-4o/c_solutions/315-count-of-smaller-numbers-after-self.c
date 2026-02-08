#include <stdlib.h>

struct BIT {
    int *tree;
    int size;
};

struct BIT* createBIT(int size) {
    struct BIT *bit = (struct BIT *)malloc(sizeof(struct BIT));
    bit->size = size + 1;
    bit->tree = (int *)calloc(bit->size, sizeof(int));
    return bit;
}

void update(struct BIT *bit, int index, int value) {
    for (; index < bit->size; index += index & -index) {
        bit->tree[index] += value;
    }
}

int query(struct BIT *bit, int index) {
    int sum = 0;
    for (; index > 0; index -= index & -index) {
        sum += bit->tree[index];
    }
    return sum;
}

int* countSmaller(int* nums, int numsSize, int* returnSize) {
    int *result = (int *)malloc(numsSize * sizeof(int));
    int *sorted = (int *)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    qsort(sorted, numsSize, sizeof(int), cmp);

    struct BIT *bit = createBIT(numsSize);
    for (int i = numsSize - 1; i >= 0; i--) {
        int index = lower_bound(sorted, sorted + numsSize, nums[i]) - sorted + 1;
        result[i] = query(bit, index - 1);
        update(bit, index, 1);
    }

    free(sorted);
    free(bit->tree);
    free(bit);
    *returnSize = numsSize;
    return result;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int lower_bound(int *arr, int *end, int target) {
    while (arr < end) {
        int *mid = arr + (end - arr) / 2;
        if (*mid < target) arr = mid + 1;
        else end = mid;
    }
    return arr - (end - arr);
}