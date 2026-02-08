#include <stdlib.h> // For malloc, free
#include <string.h> // For strlen

char* largestPalindromic(char* num) {
    int counts[10] = {0};
    for (int i = 0; num[i] != '\0'; i++) {
        counts[num[i] - '0']++;
    }

    // Use dynamic allocation for left_half_buffer to avoid stack overflow for large inputs.
    // Max length of num is 10^5, so left_half can be up to 50000 chars.
    char* left_half_buffer = (char*)malloc(sizeof(char) * (strlen(num) / 2 + 1));
    if (left_half_buffer == NULL) {
        return NULL; // Handle allocation failure
    }
    int left_half_len = 0;

    // Build the left half of the palindrome by iterating from '9' down to '0'.
    // Prioritize non-zero digits first to avoid leading zeros in the first half.
    for (int d = 9; d >= 1; d--) {
        int num_pairs = counts[d] / 2;
        for (int i = 0; i < num_pairs; i++) {
            left_half_buffer[left_half_len++] = d + '0';
        }
        counts[d] %= 2; // Update counts for remaining single digits
    }

    // Now, handle '0's for the left half.
    // '0's can only be added if left_half_buffer is not empty (i.e., left_half_len > 0).
    // If left_half_len is 0, adding '0's would make it start with '0', which is invalid unless the whole number is "0".
    if (left_half_len > 0) {
        int num_pairs_zeros = counts[0] / 2;
        for (int i = 0; i < num_pairs_zeros; i++) {
            left_half_buffer[left_half_len++] = '0';
        }
        counts[0] %= 2;
    }

    left_half_buffer[left_half_len] = '\0'; // Null-terminate the left half

    // Find the largest single digit for the middle of the palindrome
    char middle_digit = '\0';
    for (int d = 9; d >= 0; d--) {
        if (counts[d] == 1) {
            middle_digit = d + '0';
            break;
        }
    }

    // Special case: If the left half is empty and there's no middle digit,
    // it means all digits were '0's with even counts (e.g., "00", "0000").
    // In this scenario, the largest palindromic number is "0".
    // This also covers cases like `num = "0"` where `left_half_len` is 0 but `middle_digit` is '0',
    // but that specific case is handled correctly by the general construction below.
    // This `if` block specifically handles cases like "00", "0000", etc.
    if (left_half_len == 0 && middle_digit == '\0') {
        free(left_half_buffer); // Free the temporary buffer
        char* ans = (char*)malloc(2);
        if (ans == NULL) return NULL;
        ans[0] = '0';
        ans[1] = '\0';
        return ans;
    }

    // Allocate memory for the final result string
    // Max length: left_half_len + (1 for middle_digit if present) + left_half_len + 1 for null terminator
    int result_len = left_half_len * 2 + (middle_digit != '\0' ? 1 : 0);
    char* result_str = (char*)malloc(sizeof(char) * (result_len + 1));
    if (result_str == NULL) {
        free(left_half_buffer);
        return NULL; // Handle allocation failure
    }
    int res_ptr = 0;

    // Copy the left half
    for (int i = 0; i < left_half_len; i++) {
        result_str[res_ptr++] = left_half_buffer[i];
    }

    // Append the middle digit if it exists
    if (middle_digit != '\0') {
        result_str[res_ptr++] = middle_digit;
    }

    // Append the reversed left half
    for (int i = left_half_len - 1; i >= 0; i--) {
        result_str[res_ptr++] = left_half_buffer[i];
    }

    result_str[res_ptr] = '\0'; // Null-terminate the final string

    free(left_half_buffer); // Free the temporary buffer

    return result_str;
}