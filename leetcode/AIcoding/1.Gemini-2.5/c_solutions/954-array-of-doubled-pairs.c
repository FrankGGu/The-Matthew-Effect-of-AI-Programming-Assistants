#include <stdlib.h> // For qsort, abs
#include <stdbool.h> // For bool
#include <string.h> // For memset

int compare(const void *a, const void *b) {
    int valA = *(const int*)a;
    int valB = *(const int*)b;
    int absA = abs(valA);
    int absB = abs(valB);
    if (absA != absB) {
        return absA - absB;
    }
    // If absolute values are equal, sort by original value for consistent ordering
    // (e.g., -2 before 2). This specific secondary sort doesn't strictly affect correctness
    // for this problem, but it's good practice for deterministic sorting.
    return valA - valB; 
}

#define MAX_ABS_VAL 100000 // Maximum absolute value of elements in arr
#define FREQ_ARRAY_SIZE (2 * MAX_ABS_VAL + 1) // Size needed for frequency array
#define OFFSET MAX_ABS_VAL // Offset to map array values [-MAX_ABS_VAL, MAX_ABS_VAL] to [0, FREQ_ARRAY_SIZE-1]

static int freq[FREQ_ARRAY_SIZE]; 

bool canReorderDoubled(int* arr, int arrSize) {
    if (arrSize % 2 != 0) {
        return false; // Array must have even length
    }

    // Sort the array by absolute value. This ensures that for any pair (a, 2a),
    // 'a' (which has a smaller absolute value) is processed before '2a'.
    qsort(arr, arrSize, sizeof(int), compare);

    // Initialize frequency array to all zeros.
    // Using memset is faster than a loop for large arrays.
    memset(freq, 0, sizeof(freq));

    // Populate frequency array with counts of each number
    for (int i = 0; i < arrSize; i++) {
        freq[arr[i] + OFFSET]++;
    }

    // Iterate through the sorted array to form pairs
    for (int i = 0; i < arrSize; i++) {
        int x = arr[i];

        // If x has already been used as part of a pair (either as 'a' or '2a')
        // its count will be 0. Skip it.
        if (freq[x + OFFSET] == 0) {
            continue;
        }

        // We found an 'a'. Decrement its count as we are trying to form a pair with it.
        freq[x + OFFSET]--; 

        int target;
        if (x == 0) {
            target = 0; // If x is 0, its double is also 0. We need another 0.
        } else {
            target = x * 2; // For any non-zero x, we look for 2x.
        }

        // Check if the 'target' (2x) is within the valid range of array elements
        // and if it exists in the frequency map with a count > 0.
        // If target is outside the range [-MAX_ABS_VAL, MAX_ABS_VAL], it cannot exist in arr.
        if (target < -MAX_ABS_VAL || target > MAX_ABS_VAL || freq[target + OFFSET] == 0) {
            return false; // Cannot find a valid double for x
        }

        // Found the double, decrement its count.
        freq[target + OFFSET]--; 
    }

    // If all numbers were successfully paired, return true.
    return true;
}