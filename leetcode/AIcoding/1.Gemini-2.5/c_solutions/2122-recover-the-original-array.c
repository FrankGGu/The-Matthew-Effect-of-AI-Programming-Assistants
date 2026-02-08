#include <stdlib.h> // For malloc, free, qsort
#include <stdbool.h> // For bool type

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* check(int* nums, int n, int diff) {
    int* lower_arr = (int*)malloc(sizeof(int) * (n / 2));
    if (lower_arr == NULL) {
        return NULL;
    }

    char* visited = (char*)calloc(n, sizeof(char)); // Use char for bool to save space
    if (visited == NULL) {
        free(lower_arr);
        return NULL;
    }

    int lower_idx = 0;
    int i = 0; // Pointer for current lower element candidate
    int j = 1; // Pointer for current higher element candidate

    while (i < n && j < n) {
        // Skip visited elements for i
        while (i < n && visited[i]) {
            i++;
        }
        if (i >= n) break; // All elements processed

        // Ensure j is always ahead of i and not visited
        // If j is behind or at i, advance it
        if (j <= i) j = i + 1;
        while (j < n && visited[j]) {
            j++;
        }
        if (j >= n) { // No more elements for j, but i still has unvisited elements
            free(lower_arr);
            free(visited);
            return NULL;
        }

        // Now nums[i] is an unvisited potential lower element
        // and nums[j] is an unvisited potential higher element after i

        if (nums[j] == nums[i] + diff) {
            // Found a pair
            lower_arr[lower_idx++] = nums[i];
            visited[i] = 1;
            visited[j] = 1;
            i++; // Move to find next lower element
            j++; // Move to find next higher element
        } else if (nums[j] < nums[i] + diff) {
            // nums[j] is too small to be the pair for nums[i]. Try next j.
            j++;
        } else { // nums[j] > nums[i] + diff
            // nums[j] is too large for nums[i]. This means nums[i] cannot find its pair.
            // This 'diff' is invalid.
            free(lower_arr);
            free(visited);
            return NULL;
        }
    }

    // After the loop, check if we found exactly n/2 elements
    if (lower_idx == n / 2) {
        free(visited);
        return lower_arr;
    } else {
        // This means some elements were left unpaired
        free(lower_arr);
        free(visited);
        return NULL;
    }
}

int* recoverArray(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int n = numsSize;
    int lower_len = n / 2;

    for (int i = 1; i < n; ++i) { // Iterate through possible partners for nums[0]
        int diff = nums[i] - nums[0];
        if (diff == 0 || diff % 2 != 0) { // 2k must be positive and even
            continue;
        }

        int* lower_candidate = check(nums, n, diff); // check function returns NULL or the valid lower array
        if (lower_candidate != NULL) {
            *returnSize = lower_len;
            return lower_candidate;
        }
    }

    // According to problem constraints, a valid solution always exists.
    // This part should ideally not be reached.
    *returnSize = 0; 
    return NULL;
}