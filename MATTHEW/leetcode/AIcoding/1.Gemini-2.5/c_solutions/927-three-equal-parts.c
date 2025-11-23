#include <stdlib.h> // For malloc

int* threeEqualParts(int* arr, int arrSize, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = -1;
    result[1] = -1;

    int total_ones = 0;
    // Using a VLA for ones_indices, which is a C99 feature.
    // LeetCode typically supports C99/C11. Max arrSize is 30000.
    int ones_indices[arrSize]; 
    int ones_count = 0;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) {
            total_ones++;
            ones_indices[ones_count++] = i;
        }
    }

    if (total_ones == 0) {
        // If all elements are 0, any split that creates three non-empty parts works.
        // [0, 2] is a valid solution for arrSize >= 3.
        result[0] = 0;
        result[1] = 2;
        return result;
    }

    if (total_ones % 3 != 0) {
        return result; // Cannot divide ones equally
    }

    int k = total_ones / 3;

    // Find the indices of the first and last '1' for each of the three logical parts
    // Part 1: from the 1st '1' to the k-th '1'
    int p1_start = ones_indices[0];
    int p1_end = ones_indices[k - 1];

    // Part 2: from the (k+1)-th '1' to the (2k)-th '1'
    int p2_start = ones_indices[k];
    int p2_end = ones_indices[2 * k - 1];

    // Part 3: from the (2k+1)-th '1' to the (3k)-th '1'
    int p3_start = ones_indices[2 * k];
    int p3_end = ones_indices[3 * k - 1];

    // The number of trailing zeros required for each part to match the third part's value
    // This is the number of zeros after the last '1' in the entire array.
    int num_trailing_zeros = arrSize - 1 - p3_end;

    // Compare the core binary segments (from first '1' to last '1') of each part
    // They must be identical for the binary values to be equal.
    int len_segment = p1_end - p1_start; // Length of the segment - 1

    for (int i = 0; i <= len_segment; i++) {
        if (arr[p1_start + i] != arr[p2_start + i] || arr[p1_start + i] != arr[p3_start + i]) {
            return result; // Segments are not identical
        }
    }

    // Check if there are enough zeros after the '1's in P1 and P2
    // The first part ends at p1_end + num_trailing_zeros. This point must be before p2_start.
    // The second part ends at p2_end + num_trailing_zeros. This point must be before p3_start.
    if (p1_end + num_trailing_zeros >= p2_start) {
        return result; // Not enough zeros or parts overlap with '1's
    }
    if (p2_end + num_trailing_zeros >= p3_start) {
        return result; // Not enough zeros or parts overlap with '1's
    }

    // If all checks pass, calculate the split points
    result[0] = p1_end + num_trailing_zeros;
    result[1] = p2_end + num_trailing_zeros + 1;

    return result;
}