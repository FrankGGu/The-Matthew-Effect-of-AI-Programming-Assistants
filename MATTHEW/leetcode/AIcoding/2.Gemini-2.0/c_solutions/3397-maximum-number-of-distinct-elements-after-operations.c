#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int maxDistinctElements(int* nums, int numsSize, int k) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int count = 0;
    int freq_arr_size = 0;
    int* freq_arr = (int*)malloc(numsSize * sizeof(int));

    int i = 0;
    while (i < numsSize) {
        int j = i;
        while (j < numsSize && nums[i] == nums[j]) {
            j++;
        }
        int freq = j - i;
        if (freq > 1) {
            freq_arr[freq_arr_size++] = freq;
        } else {
            count++;
        }
        i = j;
    }

    qsort(freq_arr, freq_arr_size, sizeof(int), cmp);

    for (i = 0; i < freq_arr_size; i++) {
        int freq = freq_arr[i];
        if (k >= (freq - 1)) {
            k -= (freq - 1);
        } else {
            count++;
        }
    }

    count += (k >= count) ? (count) : (k);

    free(freq_arr);

    return count;
}