#include <stdbool.h>
#include <stdlib.h> // For qsort

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1); // Brian Kernighan's algorithm
        count++;
    }
    return count;
}

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool canSortArray(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return true;
    }

    int i = 0;
    while (i < numsSize) {
        int start_idx = i;
        int current_set_bits = countSetBits(nums[i]);

        // Find the end of the current segment where all elements have the same number of set bits
        int j = i + 1;
        while (j < numsSize && countSetBits(nums[j]) == current_set_bits) {
            j++;
        }
        int end_idx = j - 1;

        // Sort the segment nums[start_idx...end_idx]
        // qsort works on a contiguous block of memory.
        // The arguments are: base pointer, number of elements, size of each element, comparison function.
        qsort(nums + start_idx, end_idx - start_idx + 1, sizeof(int), compareInts);

        // Move i to the start of the next segment
        i = j;
    }

    // After sorting all segments, check if the entire array is sorted
    for (int k = 0; k < numsSize - 1; k++) {
        if (nums[k] > nums[k+1]) {
            return false;
        }
    }

    return true;
}