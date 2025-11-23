#include <string.h>

void reverse(char* str, int start, int end) {
    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        start++;
        end--;
    }
}

char* reverseWords(char* s) {
    int len = strlen(s);
    if (len == 0) {
        return s;
    }

    // Step 1: Clean and compact spaces in-place
    // Use read_idx to iterate through the original string
    // Use write_idx to write to the compacted string
    int read_idx = 0;
    int write_idx = 0;

    // Skip leading spaces
    while (read_idx < len && s[read_idx] == ' ') {
        read_idx++;
    }

    // Process characters, copying words and single spaces
    while (read_idx < len) {
        if (s[read_idx] != ' ') {
            // Copy non-space character
            s[write_idx++] = s[read_idx++];
        } else {
            // s[read_idx] is a space
            // If the last character written was not a space (i.e., we just finished a word),
            // add a single space. This handles multiple spaces between words.
            if (write_idx > 0 && s[write_idx - 1] != ' ') {
                s[write_idx++] = ' ';
            }
            read_idx++;
        }
    }

    // Remove trailing space if any
    if (write_idx > 0 && s[write_idx - 1] == ' ') {
        write_idx--;
    }

    // Null-terminate the cleaned string
    s[write_idx] = '\0';

    // Update length to the new cleaned length
    len = write_idx; 

    if (len == 0) {
        return s; // If string became empty after cleaning (e.g., "   ")
    }

    // Step 2: Reverse the entire cleaned string
    reverse(s, 0, len - 1);

    // Step 3: Reverse each word in the string
    int word_start = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] == ' ') {
            reverse(s, word_start, i - 1);
            word_start = i + 1;
        }
    }
    // Reverse the last word (or the only word if no spaces)
    reverse(s, word_start, len - 1);

    return s;
}