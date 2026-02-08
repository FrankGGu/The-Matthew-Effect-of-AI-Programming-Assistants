#include <stdlib.h>
#include <string.h>

static inline int char_to_code(char c) {
    switch (c) {
        case 'A': return 0; // 00
        case 'C': return 1; // 01
        case 'G': return 2; // 10
        case 'T': return 3; // 11
    }
    return -1; // Should not happen with valid DNA input
}

char ** findRepeatedDnaSequences(char * s, int* returnSize) {
    *returnSize = 0;
    int len = strlen(s);

    // A sequence must be 10 characters long. If the string is shorter, no sequences can be formed.
    if (len < 10) {
        return NULL;
    }

    // Use an array as a frequency map for 20-bit integer keys.
    // Each DNA character ('A', 'C', 'G', 'T') can be represented by 2 bits.
    // A 10-character sequence requires 2 * 10 = 20 bits.
    // The maximum value for a 20-bit integer is 2^20 - 1 = 1,048,575.
    // So, an array of size 1 << 20 (1,048,576) is sufficient to store frequencies.
    // calloc initializes all elements to 0.
    int* freq = (int*)calloc(1 << 20, sizeof(int));
    if (freq == NULL) {
        return NULL; // Memory allocation failed
    }

    char** result = NULL;
    int result_capacity = 0;

    unsigned int current_sequence_val = 0; // Stores the 20-bit integer representation of the current 10-char sequence

    // Iterate through the string to build a rolling hash (20-bit integer)
    for (int i = 0; i < len; ++i) {
        // Shift the current 20-bit value left by 2 bits to make room for the new character.
        // Then, mask with 0xFFFFF (which is (1 << 20) - 1) to keep only the last 20 bits, effectively
        // discarding the oldest 2 bits (the character that falls out of the 10-char window).
        current_sequence_val = (current_sequence_val << 2) & 0xFFFFF;

        // Add the 2-bit code of the new character to the rightmost position.
        current_sequence_val |= char_to_code(s[i]);

        // Once we have processed at least 10 characters (i.e., i >= 9),
        // current_sequence_val represents a full 10-character sequence.
        if (i >= 9) {
            freq[current_sequence_val]++;

            // If this sequence has been seen exactly twice, it's a repeated sequence
            // that we haven't added to our result list yet.
            if (freq[current_sequence_val] == 2) {
                // Expand the result array if its capacity is reached
                if (*returnSize == result_capacity) {
                    result_capacity = result_capacity == 0 ? 16 : result_capacity * 2; // Start with 16, then double
                    char** new_result = (char**)realloc(result, result_capacity * sizeof(char*));
                    if (new_result == NULL) {
                        // Handle realloc failure: free all previously allocated memory
                        for (int j = 0; j < *returnSize; ++j) {
                            free(result[j]);
                        }
                        free(result);
                        free(freq);
                        *returnSize = 0;
                        return NULL;
                    }
                    result = new_result;
                }

                // Allocate memory for the new sequence string (10 characters + null terminator)
                char* sequence_str = (char*)malloc(11 * sizeof(char));
                if (sequence_str == NULL) {
                    // Handle malloc failure: free all previously allocated memory
                    for (int j = 0; j < *returnSize; ++j) {
                        free(result[j]);
                    }
                    free(result);
                    free(freq);
                    *returnSize = 0;
                    return NULL;
                }

                // Copy the 10-character sequence from the original string `s`
                // The sequence starts at `s[i - 9]` and has a length of 10.
                strncpy(sequence_str, s + (i - 9), 10);
                sequence_str[10] = '\0'; // Null-terminate the string

                result[*returnSize] = sequence_str;
                (*returnSize)++;
            }
        }
    }

    free(freq); // Free the frequency array

    return result;
}