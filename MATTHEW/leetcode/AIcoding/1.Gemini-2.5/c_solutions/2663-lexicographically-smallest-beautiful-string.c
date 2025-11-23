#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

char *smallestBeautifulString(char *s, int k) {
    int n = strlen(s);

    for (int i = n - 1; i >= 0; --i) {
        // Try to increment s[i]
        for (char ch = s[i] + 1; ch < 'a' + k; ++ch) {
            // Check validity of ch at position i
            // Condition 1: ch != s[i-1]
            if (i > 0 && ch == s[i-1]) {
                continue;
            }
            // Condition 2: ch != s[i-2]
            if (i > 1 && ch == s[i-2]) {
                continue;
            }

            // If ch is valid, fix s[i] to ch
            s[i] = ch;

            // Fill subsequent positions j from i+1 to n-1 with smallest valid characters
            bool fill_success = true;
            for (int j = i + 1; j < n; ++j) {
                bool found_fill_char = false;
                for (char fill_char = 'a'; fill_char < 'a' + k; ++fill_char) {
                    // Check validity of fill_char at position j
                    // Condition 1: fill_char != s[j-1]
                    if (j > 0 && fill_char == s[j-1]) {
                        continue;
                    }
                    // Condition 2: fill_char != s[j-2]
                    if (j > 1 && fill_char == s[j-2]) {
                        continue;
                    }
                    // If fill_char is valid, set it and move to next position j
                    s[j] = fill_char;
                    found_fill_char = true;
                    break; // Found the smallest valid char for s[j]
                }
                if (!found_fill_char) {
                    fill_success = false;
                    break; // Cannot fill this position, so this choice of s[i] is invalid
                }
            }

            // If we successfully filled all characters from i+1 to n-1, then s is our answer.
            if (fill_success) {
                return s;
            }
            // If fill_success is false, this means the current 'ch' for s[i] was a bad choice.
            // The loop will continue to the next 'ch' for s[i].
        }
    }

    // If no such string found after trying all possibilities
    // Return an empty string.
    char *empty_str = (char*) malloc(sizeof(char));
    if (empty_str != NULL) {
        empty_str[0] = '\0';
    }
    return empty_str;
}