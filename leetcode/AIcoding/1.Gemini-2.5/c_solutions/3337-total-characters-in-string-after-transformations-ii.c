#include <string.h>

int getLucky(char * s, int k){
    long long current_val = 0;
    int len = strlen(s);

    // Step 1: Convert the string 's' into an initial integer sum.
    // Each character is replaced by its 1-indexed alphabet position.
    // Then, the digits of these positions are summed up.
    for (int i = 0; i < len; ++i) {
        int char_pos = s[i] - 'a' + 1; // Get 1-indexed position (e.g., 'a' -> 1, 'z' -> 26)

        // Sum the digits of char_pos
        while (char_pos > 0) {
            current_val += char_pos % 10;
            char_pos /= 10;
        }
    }

    // Step 2: Perform k-1 additional transformations.
    // The first transformation (conversion and initial digit sum) is already done above.
    // Each transformation replaces the number with the sum of its digits.
    for (int i = 0; i < k - 1; ++i) {
        long long next_val = 0;

        // Calculate the sum of digits for the current_val
        // If current_val is 0, next_val will remain 0.
        // For this problem, current_val will always be positive until it converges to a single digit.
        while (current_val > 0) {
            next_val += current_val % 10;
            current_val /= 10;
        }
        current_val = next_val;
    }

    // The final result will fit within an int.
    return (int)current_val;
}