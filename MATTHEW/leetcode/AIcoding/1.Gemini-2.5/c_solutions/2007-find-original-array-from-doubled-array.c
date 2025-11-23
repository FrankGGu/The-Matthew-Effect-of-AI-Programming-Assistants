#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

#define MAX_VAL 100000

int* findOriginalArray(int* changed, int changedSize, int* returnSize) {
    *returnSize = 0;

    if (changedSize % 2 != 0) {
        return NULL; // Cannot form pairs if length is odd
    }

    // Frequency array to store counts of numbers from 0 to MAX_VAL
    int freq[MAX_VAL + 1];
    memset(freq, 0, sizeof(freq));

    // Populate the frequency array
    for (int i = 0; i < changedSize; i++) {
        freq[changed[i]]++;
    }

    // Allocate memory for the result array
    int* result = (int*)malloc(sizeof(int) * (changedSize / 2));
    if (result == NULL) {
        return NULL; // Malloc failed
    }

    // Iterate through numbers from 0 to MAX_VAL to find original elements
    for (int i = 0; i <= MAX_VAL; i++) {
        if (freq[i] == 0) {
            continue; // No occurrences of this number
        }

        if (i == 0) {
            // Special case for zero: must have an even count to form pairs (0, 0)
            if (freq[0] % 2 != 0) {
                free(result);
                return NULL; // Odd number of zeros, cannot form pairs
            }
            // Add freq[0] / 2 zeros to the result array
            for (int k = 0; k < freq[0] / 2; k++) {
                result[(*returnSize)++] = 0;
            }
            freq[0] = 0; // All zeros processed
        } else { // For numbers greater than zero
            // Check if 2*i is within bounds and if we have enough occurrences of 2*i
            // to pair with current number i
            if (2 * i > MAX_VAL || freq[2 * i] < freq[i]) {
                free(result);
                return NULL; // Not enough doubles for current number
            }
            // Add 'i' to the result array 'freq[i]' times
            for (int k = 0; k < freq[i]; k++) {
                result[(*returnSize)++] = i;
            }
            // Consume the doubles: decrement count of 2*i
            freq[2 * i] -= freq[i];
            freq[i] = 0; // All occurrences of 'i' have been processed
        }
    }

    // If all numbers were successfully paired, *returnSize will be changedSize / 2.
    // If any number was left unpaired, a NULL would have been returned earlier.
    return result;
}