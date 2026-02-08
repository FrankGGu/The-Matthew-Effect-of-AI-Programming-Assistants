#include <stdlib.h>
#include <string.h> // For memcpy

int compareInt(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

typedef struct {
    int* tree;
    int size; // Max compressed index + 1 (i.e., number of distinct elements)
} FenwickTree;

FenwickTree* createFenwickTree(int size) {
    FenwickTree* ft = (FenwickTree*)malloc(sizeof(FenwickTree));
    ft->size = size;
    // tree is 1-indexed, so we need size+1 elements. calloc initializes to 0.
    ft->tree = (int*)calloc(size + 1, sizeof(int)); 
    return ft;
}

void updateFenwickTree(FenwickTree* ft, int idx, int val) {
    idx++; // Convert to 1-indexed
    while (idx <= ft->size) {
        ft->tree[idx] += val;
        idx += idx & (-idx);
    }
}

int queryFenwickTree(FenwickTree* ft, int idx) {
    idx++; // Convert to 1-indexed
    int sum = 0;
    while (idx > 0) {
        sum += ft->tree[idx];
        idx -= idx & (-idx);
    }
    return sum;
}

void freeFenwickTree(FenwickTree* ft) {
    free(ft->tree);
    free(ft);
}

int get_compressed_idx(int val, int* unique_sorted_nums, int distinct_count) {
    // bsearch returns a pointer to the found element
    int* p = (int*)bsearch(&val, unique_sorted_nums, distinct_count, sizeof(int), compareInt);
    // The index is the difference in pointers divided by element size
    return (int)(p - unique_sorted_nums);
}

int* distributeElements(int* nums, int numsSize, int* returnSize) {
    // Problem constraints state numsSize will be at least 2.

    // 1. Coordinate Compression
    // Create a copy of nums to sort and find unique elements
    int* temp_nums_copy = (int*)malloc(numsSize * sizeof(int));
    memcpy(temp_nums_copy, nums, numsSize * sizeof(int));
    qsort(temp_nums_copy, numsSize, sizeof(int), compareInt);

    // Filter unique elements
    int* unique_sorted_nums = (int*)malloc(numsSize * sizeof(int)); // Max possible size
    int distinct_count = 0;
    if (numsSize > 0) { // numsSize >= 2 per constraints
        unique_sorted_nums[distinct_count++] = temp_nums_copy[0];
        for (int i = 1; i < numsSize; i++) {
            if (temp_nums_copy[i] != temp_nums_copy[i-1]) {
                unique_sorted_nums[distinct_count++] = temp_nums_copy[i];
            }
        }
    }
    free(temp_nums_copy); // No longer needed

    // The compressed indices will range from 0 to distinct_count - 1.
    // BIT size will be 'distinct_count' to cover all these indices.
    int compressed_bit_size = distinct_count;

    // Allocate space for arr1 and arr2. Max possible size for each is numsSize.
    int* arr1 = (int*)malloc(numsSize * sizeof(int));
    int* arr2 = (int*)malloc(numsSize * sizeof(int));
    int arr1_len = 0;
    int arr2_len = 0;

    // Create Fenwick Trees for arr1 and arr2 counts
    FenwickTree* ft1 = createFenwickTree(compressed_bit_size);
    FenwickTree* ft2 = createFenwickTree(compressed_bit_size);

    // Initial distribution based on problem rules:
    // nums[0] to arr1
    arr1[arr1_len++] = nums[0];
    updateFenwickTree(ft1, get_compressed_idx(nums[0], unique_sorted_nums, distinct_count), 1);

    // nums[1] to arr2
    arr2[arr2_len++] = nums[1];
    updateFenwickTree(ft2, get_compressed_idx(nums[1], unique_sorted_nums, distinct_count), 1);

    // Distribute remaining elements from nums[2] onwards
    for (int i = 2; i < numsSize; i++) {
        int current_num = nums[i];
        int compressed_idx = get_compressed_idx(current_num, unique_sorted_nums, distinct_count);

        // Calculate count1: number of elements in arr1 strictly greater than current_num
        // Total elements in arr1 = queryFenwickTree(ft1, compressed_bit_size - 1)
        // Elements <= current_num in arr1 = queryFenwickTree(ft1, compressed_idx)
        int count1 = queryFenwickTree(ft1, compressed_bit_size - 1) - queryFenwickTree(ft1, compressed_idx);

        // Calculate count2: number of elements in arr2 strictly greater than current_num
        int count2 = queryFenwickTree(ft2, compressed_bit_size - 1) - queryFenwickTree(ft2, compressed_idx);

        // Apply distribution rules
        if (count1 > count2) {
            arr1[arr1_len++] = current_num;
            updateFenwickTree(ft1, compressed_idx, 1);
        } else if (count2 > count1) {
            arr2[arr2_len++] = current_num;
            updateFenwickTree(ft2, compressed_idx, 1);
        } else { // count1 == count2
            if (arr1_len <= arr2_len) {
                arr1[arr1_len++] = current_num;
                updateFenwickTree(ft1, compressed_idx, 1);
            } else {
                arr2[arr2_len++] = current_num;
                updateFenwickTree(ft2, compressed_idx, 1);
            }
        }
    }

    // Concatenate arr1 and arr2 into the final result array
    *returnSize = arr1_len + arr2_len;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    memcpy(result, arr1, arr1_len * sizeof(int));
    memcpy(result + arr1_len, arr2, arr2_len * sizeof(int));

    // Cleanup allocated memory
    free(unique_sorted_nums);
    free(arr1);
    free(arr2);
    freeFenwickTree(ft1);
    freeFenwickTree(ft2);

    return result;
}