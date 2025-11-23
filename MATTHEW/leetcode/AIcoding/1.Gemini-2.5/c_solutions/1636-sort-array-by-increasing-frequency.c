#include <stdlib.h>

int global_freq[201]; // Using a global array to store frequencies, mapping num to index (num + 100)

int compare(const void *a, const void *b) {
    int val1 = *(const int *)a;
    int val2 = *(const int *)b;

    int f1 = global_freq[val1 + 100];
    int f2 = global_freq[val2 + 100];

    if (f1 != f2) {
        return f1 - f2; // Sort by frequency in increasing order
    } else {
        return val2 - val1; // Sort by value in decreasing order if frequencies are the same
    }
}

int* frequencySort(int* nums, int numsSize, int* returnSize) {
    for (int i = 0; i < 201; i++) {
        global_freq[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        global_freq[nums[i] + 100]++;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    *returnSize = numsSize;
    return nums;
}