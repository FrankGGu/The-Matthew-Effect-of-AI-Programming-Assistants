#include <stdlib.h>
#include <string.h>

char **findRepeatedDnaSequences(char *s, int *returnSize) {
    *returnSize = 0;
    int n = strlen(s);

    if (n < 10) {
        return NULL;
    }

    // Use an array as a frequency map for 20-bit encoded sequences.
    // Max value for 20 bits is 2^20 - 1 = 1048575.
    // We need 1048576 elements.
    // Using signed char to save memory, as counts will only go up to 2 (or more, but we only care about 2).
    // If a sequence appears more than twice, we still only add it once to the result list.
    signed char *counts = (signed char *)calloc(1 << 20, sizeof(signed char));
    if (!counts) {
        return NULL;
    }

    // Dynamic array to store results. Max possible unique repeated sequences is (n-9)/2,
    // so n is a safe upper bound for initial allocation.
    char **result = (char **)malloc(n * sizeof(char *)); 
    if (!result) {
        free(counts);
        return NULL;
    }

    // Map characters to 2-bit integers
    // A -> 00 (0)
    // C -> 01 (1)
    // G -> 10 (2)
    // T -> 11 (3)
    int char_to_int[128]; // Using ASCII values as indices
    char_to_int['A'] = 0;
    char_to_int['C'] = 1;
    char_to_int['G'] = 2;
    char_to_int['T'] = 3;

    unsigned int current_key = 0;
    // Calculate initial key for the first 9 characters
    // This initializes the sliding window.
    for (int i = 0; i < 9; ++i) {
        current_key = (current_key << 2) | char_to_int[s[i]];
    }

    // Slide the window through the string
    for (int i = 0; i <= n - 10; ++i) {
        // Add the new character (s[i+9]) to the window
        current_key = (current_key << 2) | char_to_int[s[i + 9]];
        // Mask to keep only the last 20 bits (10 characters * 2 bits/char)
        // This effectively removes the oldest character from the window.
        current_key &= 0xFFFFF; // 0b11111111111111111111 (20 ones)

        counts[current_key]++;

        if (counts[current_key] == 2) {
            // This sequence is seen for the second time, add it to results
            char *dna_sequence = (char *)malloc(11 * sizeof(char)); // 10 chars + null terminator
            if (!dna_sequence) {
                // Handle allocation failure, free previously allocated memory and return.
                for (int j = 0; j < *returnSize; ++j) {
                    free(result[j]);
                }
                free(result);
                free(counts);
                return NULL;
            }
            strncpy(dna_sequence, s + i, 10);
            dna_sequence[10] = '\0';
            result[*returnSize] = dna_sequence;
            (*returnSize)++;
        }
    }

    free(counts);
    return result;
}