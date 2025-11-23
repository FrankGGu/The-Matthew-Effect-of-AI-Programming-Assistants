#include <stdlib.h> // For qsort, malloc, free

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minOperations(int* nums, int numsSize, int* target, int targetSize) {
    // Dynamically allocate arrays for even and odd numbers.
    // Max size for each is numsSize (or targetSize, which is the same).
    // We allocate numsSize for simplicity, even though max actual elements
    // in an even/odd array would be numsSize.
    int* nums_even = (int*)malloc(sizeof(int) * numsSize);
    int* nums_odd = (int*)malloc(sizeof(int) * numsSize);
    int* target_even = (int*)malloc(sizeof(int) * numsSize);
    int* target_odd = (int*)malloc(sizeof(int) * numsSize);

    int nums_even_count = 0;
    int nums_odd_count = 0;
    int target_even_count = 0;
    int target_odd_count = 0;

    // Separate numbers from 'nums' into even and odd arrays
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            nums_even[nums_even_count++] = nums[i];
        } else {
            nums_odd[nums_odd_count++] = nums[i];
        }
    }

    // Separate numbers from 'target' into even and odd arrays
    for (int i = 0; i < targetSize; i++) {
        if (target[i] % 2 == 0) {
            target_even[target_even_count++] = target[i];
        } else {
            target_odd[target_odd_count++] = target[i];
        }
    }

    // Sort all four arrays to enable direct comparison of elements
    qsort(nums_even, nums_even_count, sizeof(int), compare);
    qsort(nums_odd, nums_odd_count, sizeof(int), compare);
    qsort(target_even, target_even_count, sizeof(int), compare);
    qsort(target_odd, target_odd_count, sizeof(int), compare);

    long long operations = 0;

    // Calculate operations needed for even numbers
    // We only sum the "excess" values (nums[i] > target[i]) because each operation
    // moves 2 units of value. The total excess must equal the total deficit.
    // Summing only one side (e.g., excess) gives the total number of 2-unit transfers.
    for (int i = 0; i < nums_even_count; i++) {
        if (nums_even[i] > target_even[i]) {
            operations += (long long)(nums_even[i] - target_even[i]) / 2;
        }
    }

    // Calculate operations needed for odd numbers
    for (int i = 0; i < nums_odd_count; i++) {
        if (nums_odd[i] > target_odd[i]) {
            operations += (long long)(nums_odd[i] - target_odd[i]) / 2;
        }
    }

    // Free the dynamically allocated memory
    free(nums_even);
    free(nums_odd);
    free(target_even);
    free(target_odd);

    return operations;
}