#include <stdlib.h> // For malloc, free
#include <string.h> // For memcpy

static long long mergeAndCount(int* arr, int left, int mid, int right, int diff, int* temp) {
    long long count = 0;

    // Counting step for pairs (i, j) where i in left half, j in right half
    // We need to count pairs such that arr[i] <= arr[j] + diff
    // This is equivalent to arr[j] >= arr[i] - diff
    int j_ptr = mid + 1;
    for (int i_ptr = left; i_ptr <= mid; ++i_ptr) {
        // Advance j_ptr to find the first element in the right half
        // that satisfies arr[j_ptr] >= arr[i_ptr] - diff
        while (j_ptr <= right && arr[j_ptr] < arr[i_ptr] - diff) {
            j_ptr++;
        }
        // All elements from j_ptr to right (inclusive) satisfy the condition
        // for the current arr[i_ptr].
        if (j_ptr <= right) {
            count += (right - j_ptr + 1);
        }
    }

    // Standard merge step to sort the subarray arr[left...right]
    int i = left;
    int j = mid + 1;
    int k = 0; // Index for the temporary array

    while (i <= mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = arr[i++];
    }

    while (j <= right) {
        temp[k++] = arr[j++];
    }

    // Copy merged elements back to the original array
    for (i = 0; i < k; ++i) {
        arr[left + i] = temp[i];
    }

    return count;
}

static long long mergeSortAndCountWrapper(int* arr, int left, int right, int diff, int* temp) {
    if (left >= right) {
        return 0;
    }

    int mid = left + (right - left) / 2;
    long long count = 0;

    // Recursively count pairs in left and right halves
    count += mergeSortAndCountWrapper(arr, left, mid, diff, temp);
    count += mergeSortAndCountWrapper(arr, mid + 1, right, diff, temp);

    // Count pairs across the two halves and merge them
    count += mergeAndCount(arr, left, mid, right, diff, temp);

    return count;
}

int numberOfPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int diff) {
    if (nums1Size == 0) {
        return 0;
    }

    // Create a transformed array where transformed_nums[k] = nums1[k] - nums2[k]
    int* transformed_nums = (int*)malloc(nums1Size * sizeof(int));
    if (transformed_nums == NULL) {
        return 0; // Handle allocation error
    }
    for (int i = 0; i < nums1Size; ++i) {
        transformed_nums[i] = nums1[i] - nums2[i];
    }

    // Allocate a temporary array for the merge sort process
    // This temporary array should be large enough to hold the merged elements of any sub-array
    int* temp = (int*)malloc(nums1Size * sizeof(int));
    if (temp == NULL) {
        free(transformed_nums);
        return 0; // Handle allocation error
    }

    // Call the merge sort and count function
    long long total_pairs = mergeSortAndCountWrapper(transformed_nums, 0, nums1Size - 1, diff, temp);

    // Clean up allocated memory
    free(transformed_nums);
    free(temp);

    // The problem asks for an 'int' return type, but the count can exceed INT_MAX (up to 5*10^9).
    // We return the long long count cast to int, which might truncate on some systems
    // if the actual count exceeds INT_MAX. However, this adheres to the function signature.
    return (int)total_pairs;
}