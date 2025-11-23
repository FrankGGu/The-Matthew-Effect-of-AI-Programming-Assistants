#include <stdlib.h> // For qsort
#include <string.h> // For memset

int total_beautiful_subsets;
int freq[1001]; // Max value of nums[i] is 1000. Indices 0-1000.

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

void backtrack(int index, int* nums, int numsSize, int k) {
    // Base case: All numbers have been considered
    if (index == numsSize) {
        total_beautiful_subsets++;
        return;
    }

    // Option 1: Exclude nums[index] from the current subset
    backtrack(index + 1, nums, numsSize, k);

    // Option 2: Include nums[index] in the current subset
    int current_num = nums[index];

    // Check if including current_num violates the beautiful subset condition
    // Since nums is sorted and we process from left to right,
    // any element already in the subset must be smaller than current_num.
    // Therefore, we only need to check if (current_num - k) is already in the subset.
    // (current_num + k) cannot be in the subset because it would be a number
    // greater than current_num, which would contradict it being already
    // processed and added.
    if (current_num - k >= 0 && freq[current_num - k] > 0) {
        // Condition violated, cannot include nums[index]
        return;
    }

    // If condition is not violated, include nums[index]
    freq[current_num]++;
    backtrack(index + 1, nums, numsSize, k);
    freq[current_num]--; // Backtrack: remove nums[index] for other paths
}

int beautifulSubsets(int* nums, int numsSize, int k) {
    // Sort the input array to simplify the condition checking logic
    qsort(nums, numsSize, sizeof(int), compare);

    // Initialize frequency array to all zeros
    memset(freq, 0, sizeof(freq));

    total_beautiful_subsets = 0;
    backtrack(0, nums, numsSize, k);

    // The problem examples suggest the empty set is counted as a beautiful subset.
    // If it were not, we would return total_beautiful_subsets - 1.
    return total_beautiful_subsets;
}