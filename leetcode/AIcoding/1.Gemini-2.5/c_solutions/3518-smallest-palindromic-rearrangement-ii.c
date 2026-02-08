#include <string.h>
#include <stdlib.h>

char* smallestPalindromicRearrangement(char* s) {
    int freq[26] = {0};
    int len = strlen(s);

    // Count character frequencies
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    char middle_char = '\0';
    // Identify the single character with odd frequency (if any)
    // A valid palindrome rearrangement must have at most one character with an odd frequency.
    // The problem implies that a palindrome can always be formed.
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            middle_char = (char)('a' + i);
            freq[i]--; // Decrement its count so the remaining count is even for the halves
            break; // Only one such character can be the middle character
        }
    }

    // Determine the length of the first half of the palindrome
    int first_half_len = 0;
    for (int i = 0; i < 26; i++) {
        first_half_len += freq[i] / 2;
    }

    // Allocate memory for the first half buffer
    char* first_half_buffer = (char*)malloc(sizeof(char) * (first_half_len + 1));
    int buffer_idx = 0;

    // Build the first half of the palindrome lexicographically
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < freq[i] / 2; j++) {
            first_half_buffer[buffer_idx++] = (char)('a' + i);
        }
    }
    first_half_buffer[buffer_idx] = '\0';

    // Allocate memory for the final result string
    char* result = (char*)malloc(sizeof(char) * (len + 1));
    int current_result_idx = 0;

    // Copy the first half to the result string
    strcpy(result, first_half_buffer);
    current_result_idx = first_half_len;

    // Add the middle character if it exists
    if (middle_char != '\0') {
        result[current_result_idx++] = middle_char;
    }

    // Append the reversed first half to complete the palindrome
    for (int i = first_half_len - 1; i >= 0; i--) {
        result[current_result_idx++] = first_half_buffer[i];
    }
    result[current_result_idx] = '\0';

    // Free the temporary buffer
    free(first_half_buffer);

    return result;
}