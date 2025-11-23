#include <string.h>

int maximumPalindromes(char **words, int wordsSize) {
    int char_counts[26] = {0};

    // Step 1: Count character frequencies across all strings
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        for (int j = 0; j < len; j++) {
            char_counts[words[i][j] - 'a']++;
        }
    }

    // Step 2: Count character types with an odd total frequency
    // These represent "odd-slots" that must be used by odd-length palindromes.
    int odd_freq_char_types = 0;
    for (int i = 0; i < 26; i++) {
        if (char_counts[i] % 2 == 1) {
            odd_freq_char_types++;
        }
    }

    // Step 3: Determine the maximum number of palindromes
    int palindromes_count = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        if (len % 2 == 0) {
            // An even-length string can always be rearranged into a palindrome
            // if all characters assigned to it appear an even number of times.
            // Since we prioritize assigning "odd-slots" to odd-length strings,
            // any characters effectively remaining for even-length strings
            // will have even counts (or can be combined to form even counts).
            palindromes_count++;
        } else {
            // An odd-length string requires exactly one character to appear an odd number of times.
            // We use one of the available "odd-slots" from the total character pool.
            if (odd_freq_char_types > 0) {
                palindromes_count++;
                odd_freq_char_types--; // This odd-slot is now "used"
            }
            // If odd_freq_char_types is 0, there are no more character types
            // with an odd total count available to satisfy the requirement
            // for this odd-length string. Thus, it cannot be a palindrome.
        }
    }

    return palindromes_count;
}