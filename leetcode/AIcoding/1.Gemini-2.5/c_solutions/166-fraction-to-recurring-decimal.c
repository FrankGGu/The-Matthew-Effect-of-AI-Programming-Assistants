#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <math.h> // For llabs

#include "uthash.h"

typedef struct {
    long long remainder; // Key: the remainder
    int index;           // Value: the position in the result string where this remainder first occurred
    UT_hash_handle hh;   // UTHash handle
} RemainderEntry;

char * fractionToDecimal(int numerator, int denominator){
    // Handle zero numerator
    if (numerator == 0) {
        return strdup("0"); // strdup allocates memory, caller must free
    }

    // Allocate a buffer for the result string.
    // Max length could be very large (up to denominator-1 for repeating part),
    // but LeetCode test cases usually don't hit extreme values for memory limits.
    // A buffer of 20000-20005 is often sufficient for such problems.
    char *result = (char *)malloc(sizeof(char) * 20005);
    if (!result) {
        return NULL; // Handle allocation failure
    }
    int res_idx = 0; // Current index in the result string

    // Use long long for calculations to prevent overflow, especially with INT_MIN
    long long l_numerator = numerator;
    long long l_denominator = denominator;

    // Determine the sign of the result
    // XOR operation checks if exactly one of them is negative
    if ((l_numerator < 0) ^ (l_denominator < 0)) {
        result[res_idx++] = '-';
    }

    // Take absolute values for core division logic
    l_numerator = llabs(l_numerator);
    l_denominator = llabs(l_denominator);

    // Calculate the integer part
    long long integer_part = l_numerator / l_denominator;
    // Use sprintf to convert integer_part to string and append to result
    res_idx += sprintf(result + res_idx, "%lld", integer_part);

    // Calculate the first remainder
    long long remainder = l_numerator % l_denominator;

    // If remainder is 0, the fraction is terminating
    if (remainder == 0) {
        result[res_idx] = '\0'; // Null-terminate the string
        return result;
    }

    // If there's a fractional part, append a decimal point
    result[res_idx++] = '.';

    // Initialize the hash table for tracking remainders
    RemainderEntry *remainder_map = NULL; // Head of the UTHash table

    // Loop to calculate fractional digits and detect repetition
    while (remainder != 0) {
        RemainderEntry *entry;
        // Check if the current remainder has been seen before
        HASH_FIND_LONG(remainder_map, &remainder, entry);

        if (entry != NULL) {
            // Repetition detected!
            // Insert '(' at the position where this remainder first occurred (entry->index)
            // Shift characters from entry->index to current res_idx one position to the right
            memmove(result + entry->index + 1, result + entry->index, res_idx - entry->index);
            result[entry->index] = '(';
            res_idx++; // Increment res_idx due to inserted character
            result[res_idx++] = ')'; // Append ')' at the current end
            break; // Exit loop after handling repetition
        }

        // If remainder is new, add it to the hash map with its current position
        entry = (RemainderEntry *)malloc(sizeof(RemainderEntry));
        if (!entry) { // Handle allocation failure for hash entry
            // Clean up all allocated memory before returning NULL
            RemainderEntry *current_entry, *tmp;
            HASH_ITER(hh, remainder_map, current_entry, tmp) {
                HASH_DEL(remainder_map, current_entry);
                free(current_entry);
            }
            free(result);
            return NULL;
        }
        entry->remainder = remainder;
        entry->index = res_idx; // Store the index where the digit corresponding to this remainder will be placed
        HASH_ADD_LONG(remainder_map, remainder, entry);

        // Multiply remainder by 10 to get the next digit
        remainder *= 10;
        // Append the next digit to the result string
        result[res_idx++] = (char)((remainder / l_denominator) + '0');
        // Calculate the new remainder
        remainder %= l_denominator;
    }

    // Null-terminate the final string
    result[res_idx] = '\0';

    // Clean up the hash table: free all entries
    RemainderEntry *current_entry, *tmp;
    HASH_ITER(hh, remainder_map, current_entry, tmp) {
        HASH_DEL(remainder_map, current_entry);
        free(current_entry);
    }

    return result;
}