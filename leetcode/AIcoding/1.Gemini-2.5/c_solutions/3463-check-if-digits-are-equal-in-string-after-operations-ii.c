#include <stdbool.h>
#include <string.h>
#include <stdio.h> // For sprintf

bool checkIfDigitsAreEqual(char* s, int k) {
    // According to LeetCode problem 1945 constraints:
    // 1 <= s.length <= 100
    // 1 <= k <= 100
    //
    // Max sum of k (100) digits (all '9') is 900.
    // sprintf(sum_str, "%d", 900) results in "900" (3 characters).
    //
    // If original string length L=100 and k=3:
    // Number of groups = ceil(100/3) = 34.
    // Max new string length = 34 * (max digits in sum, which is 3) = 102.
    // So, buffers of size 103 (for null terminator) are sufficient.
    // Using 105 for a bit of extra safety.
    char s_buffer[105];
    char next_s_buffer[105];

    strcpy(s_buffer, s);

    // Continue operations as long as the string length is greater than k
    while (strlen(s_buffer) > k) {
        next_s_buffer[0] = '\0'; // Clear next_s_buffer for new concatenation
        int current_len = strlen(s_buffer);

        // Process the string in groups of size k
        for (int i = 0; i < current_len; i += k) {
            int sum = 0;
            // Calculate sum for the current group
            for (int j = 0; j < k && (i + j) < current_len; ++j) {
                sum += (s_buffer[i + j] - '0');
            }

            // Convert the sum to its string representation and append to next_s_buffer
            char sum_str[5]; // Max sum 900 -> "900" (3 chars) + '\0' -> 4 chars. 5 is safe.
            sprintf(sum_str, "%d", sum);
            strcat(next_s_buffer, sum_str);
        }
        // Update s_buffer for the next iteration with the newly formed string
        strcpy(s_buffer, next_s_buffer);
    }

    // After the loop, check if all digits in the final s_buffer are equal
    int final_len = strlen(s_buffer);
    if (final_len == 0) {
        // An empty string has no digits, so they are vacuously equal.
        // Problem constraints usually ensure s is not empty after operations.
        return true; 
    }

    char first_digit = s_buffer[0];
    for (int i = 1; i < final_len; ++i) {
        if (s_buffer[i] != first_digit) {
            return false; // Found a digit that is not equal to the first one
        }
    }

    return true; // All digits are equal
}