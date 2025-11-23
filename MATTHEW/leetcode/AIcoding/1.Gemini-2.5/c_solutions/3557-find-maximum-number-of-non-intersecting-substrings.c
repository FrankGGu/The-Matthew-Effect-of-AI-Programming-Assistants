#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    int start;
    int end;
} Substring;

char** findMaximumNumberofNonIntersectingSubstrings(char* s, int* returnSize) {
    int n = strlen(s);

    // Arrays to store the first and last occurrence index for each character 'a' through 'z'
    int first_occurrence[26];
    int last_occurrence[26];

    // Initialize first_occurrence to n (or any value indicating not found yet)
    // Initialize last_occurrence to -1 (or any value indicating not found yet)
    for (int k = 0; k < 26; ++k) {
        first_occurrence[k] = n;
        last_occurrence[k] = -1;
    }

    // Populate first_occurrence and last_occurrence arrays
    for (int k = 0; k < n; ++k) {
        int char_idx = s[k] - 'a';
        if (first_occurrence[char_idx] == n) {
            first_occurrence[char_idx] = k;
        }
        last_occurrence[char_idx] = k;
    }

    // Dynamic array to store the found good substrings (as Substring structs)
    Substring* good_substrings_list = NULL;
    int good_substrings_count = 0;
    int good_substrings_capacity = 0;

    int i = 0; // Current starting index for potential good substrings
    while (i < n) {
        // If s[i] has an occurrence before 'i', then any substring starting at 'i'
        // that includes s[i] cannot be a "good" substring because not all occurrences
        // of s[i] would be within s[i...j]. So, we skip this 'i'.
        if (first_occurrence[s[i] - 'a'] != i) {
            i++;
            continue;
        }

        // Initialize the current segment's maximum end to the last occurrence of s[i]
        int current_max_end = last_occurrence[s[i] - 'a'];
        bool is_valid_good_substring = true;

        // Iterate through the characters from 'i' up to current_max_end
        // to expand the segment and check the "good" condition.
        int k = i;
        while (k <= current_max_end) {
            int char_idx = s[k] - 'a';

            // If any character s[k] within the current segment [i...current_max_end]
            // has an occurrence before 'i', then this segment cannot be a good substring
            // starting at 'i'.
            if (first_occurrence[char_idx] < i) {
                is_valid_good_substring = false;
                // If it's not a valid good substring starting at 'i',
                // we can safely skip 'i' to current_max_end + 1.
                // Any substring starting within [i, current_max_end] and ending within this segment
                // would also contain s[k] (or another character causing invalidity) and thus be invalid.
                i = current_max_end + 1;
                break; // Exit inner while loop
            }

            // Extend current_max_end to ensure all occurrences of s[k] are within the segment.
            if (last_occurrence[char_idx] > current_max_end) {
                current_max_end = last_occurrence[char_idx];
            }
            k++;
        }

        if (is_valid_good_substring) {
            // If we reached here, it means for all characters in s[i...current_max_end]:
            // 1. Their first occurrence is >= i
            // 2. Their last occurrence is <= current_max_end
            // So, s[i...current_max_end] is a good substring.

            // Add it to our list of good substrings
            if (good_substrings_count == good_substrings_capacity) {
                good_substrings_capacity = good_substrings_capacity == 0 ? 1 : good_substrings_capacity * 2;
                good_substrings_list = (Substring*)realloc(good_substrings_list, good_substrings_capacity * sizeof(Substring));
            }
            good_substrings_list[good_substrings_count++] = (Substring){i, current_max_end};

            // The next potential good substring must start after the end of this one
            // to ensure non-intersection.
            i = current_max_end + 1;
        }
        // If not a valid good substring, 'i' was already jumped in the 'k' loop.
    }

    // The good_substrings_list now contains all maximal non-overlapping good substrings.
    // Since they are already non-overlapping and generated in increasing order of start/end,
    // we simply need to convert them to string format and return.

    char** result = (char**)malloc(good_substrings_count * sizeof(char*));
    *returnSize = good_substrings_count;

    for (int j = 0; j < good_substrings_count; ++j) {
        int start = good_substrings_list[j].start;
        int end = good_substrings_list[j].end;
        int len = end - start + 1;

        result[j] = (char*)malloc((len + 1) * sizeof(char));
        strncpy(result[j], s + start, len);
        result[j][len] = '\0'; // Null-terminate the substring
    }

    free(good_substrings_list); // Free the temporary list of structs

    return result;
}