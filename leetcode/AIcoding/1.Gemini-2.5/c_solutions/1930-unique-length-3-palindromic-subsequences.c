#include <string.h>
#include <stdbool.h>

int countPalindromicSubsequences(char * s) {
    int n = strlen(s);
    int total_palindromes = 0;

    // Arrays to store the first and last occurrence index for each character 'a' through 'z'
    int first_occurrence[26];
    int last_occurrence[26];

    // Initialize occurrence arrays. -1 indicates not found.
    for (int i = 0; i < 26; i++) {
        first_occurrence[i] = -1;
        last_occurrence[i] = -1;
    }

    // Populate first and last occurrence indices
    for (int i = 0; i < n; i++) {
        int char_code = s[i] - 'a';
        if (first_occurrence[char_code] == -1) {
            first_occurrence[char_code] = i;
        }
        last_occurrence[char_code] = i;
    }

    // Iterate through each possible character 'a' (from 'a' to 'z') to be the outer character of the palindrome 'a_a'
    for (int i = 0; i < 26; i++) {
        int first_idx = first_occurrence[i];
        int last_idx = last_occurrence[i];

        // If the character does not appear, or appears only once, it cannot form a length-3 palindrome 'a_a'
        if (first_idx == -1 || first_idx == last_idx) {
            continue;
        }

        // Use a boolean array to track unique characters found between first_idx and last_idx
        // These unique characters will serve as the middle character 'b' in 'aba'
        bool seen_middle_chars[26] = {false}; // All initialized to false
        int unique_middle_count = 0;

        // Iterate through the substring strictly between the first and last occurrences of the current outer character
        for (int j = first_idx + 1; j < last_idx; j++) {
            int middle_char_code = s[j] - 'a';
            if (!seen_middle_chars[middle_char_code]) {
                seen_middle_chars[middle_char_code] = true;
                unique_middle_count++;
            }
        }
        // Add the count of unique middle characters found for this outer character to the total
        total_palindromes += unique_middle_count;
    }

    return total_palindromes;
}