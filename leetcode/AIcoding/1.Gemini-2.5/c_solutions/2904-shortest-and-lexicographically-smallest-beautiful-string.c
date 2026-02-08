#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

char* shortestBeautifulString(int k, char* forbidden) {
    // According to the problem description, a beautiful string must be a palindrome
    // and no two adjacent digits can be the same.
    // If k is even, let the string be s[0]...s[k-1].
    // For it to be a palindrome, s[k/2 - 1] must be equal to s[k/2].
    // For no two adjacent digits to be the same, s[k/2 - 1] must not be equal to s[k/2].
    // These two conditions contradict each other.
    // Therefore, no beautiful string can exist if k is even.
    if (k % 2 == 0) {
        char* empty_string = (char*)malloc(sizeof(char));
        empty_string[0] = '\0';
        return empty_string;
    }

    // Prepare a boolean array to quickly check if a digit is forbidden.
    bool is_forbidden[10] = {false};
    for (int i = 0; forbidden[i] != '\0'; ++i) {
        is_forbidden[forbidden[i] - '0'] = true;
    }

    // Allocate memory for the result string. +1 for the null terminator.
    char* result = (char*)malloc((k + 1) * sizeof(char));
    result[k] = '\0'; // Null-terminate the string

    // A palindrome of odd length k is determined by its first (k+1)/2 characters.
    // For example, if k=3, we determine s[0] and s[1]. s[2] will be s[0].
    // If k=5, we determine s[0], s[1], s[2]. s[3] will be s[1], s[4] will be s[0].
    int half_len = (k + 1) / 2;

    // Construct the first half of the palindrome (including the middle character for odd k).
    for (int i = 0; i < half_len; ++i) {
        // The previous character, used to enforce the "no two adjacent digits are the same" rule.
        // For the first character (i=0), there is no previous character, so we use '\0' as a sentinel.
        char prev_char = (i > 0) ? result[i-1] : '\0';
        bool found_digit = false;

        // Iterate through digits '0' to '9' to find the lexicographically smallest valid digit.
        for (int d = 0; d <= 9; ++d) {
            char current_char = d + '0';

            // Check if the digit is forbidden.
            if (is_forbidden[d]) {
                continue;
            }

            // Check if the digit is the same as the previous character.
            if (current_char == prev_char) {
                continue;
            }

            // If all conditions are met, this is the smallest valid digit for the current position.
            result[i] = current_char;
            found_digit = true;
            break; // Move to the next position
        }

        // If no valid digit could be found for the current position,
        // then no beautiful string of length k exists.
        if (!found_digit) {
            free(result); // Free the partially constructed string
            char* empty_string = (char*)malloc(sizeof(char));
            empty_string[0] = '\0';
            return empty_string;
        }
    }

    // Fill the second half of the palindrome based on the first half.
    // s[i] = s[k-1-i]
    for (int i = half_len; i < k; ++i) {
        result[i] = result[k - 1 - i];
    }

    return result;
}