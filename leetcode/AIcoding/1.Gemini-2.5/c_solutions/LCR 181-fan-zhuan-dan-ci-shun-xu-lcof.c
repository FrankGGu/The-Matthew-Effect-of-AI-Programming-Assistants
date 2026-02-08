#include <string.h> // For strlen

void reverse(char* s, int left, int right) {
    while (left < right) {
        char temp = s[left];
        s[left] = s[right];
        s[right] = temp;
        left++;
        right--;
    }
}

char* reverseWords(char* s) {
    int n = strlen(s);

    // Step 1: Remove extra spaces and consolidate to a single space between words
    // And move valid content to the beginning of the string
    int write_idx = 0;
    int read_idx = 0;

    // Skip leading spaces
    while (read_idx < n && s[read_idx] == ' ') {
        read_idx++;
    }

    while (read_idx < n) {
        // Copy non-space characters
        while (read_idx < n && s[read_idx] != ' ') {
            s[write_idx++] = s[read_idx++];
        }

        // If we copied a word and there are more characters (meaning s[read_idx] is a space)
        if (read_idx < n) {
            s[write_idx++] = ' '; // Add a single space
            // Skip multiple spaces
            while (read_idx < n && s[read_idx] == ' ') {
                read_idx++;
            }
        }
    }

    // Handle potential trailing space if the last character written was a space
    if (write_idx > 0 && s[write_idx - 1] == ' ') {
        write_idx--;
    }
    s[write_idx] = '\0'; // Null-terminate the new string

    int new_len = write_idx;

    // Step 2: Reverse the entire string
    reverse(s, 0, new_len - 1);

    // Step 3: Reverse each word
    int word_start = 0;
    for (int i = 0; i < new_len; i++) {
        if (s[i] == ' ') {
            reverse(s, word_start, i - 1);
            word_start = i + 1;
        }
    }
    // Reverse the last word (from word_start to new_len - 1)
    reverse(s, word_start, new_len - 1);

    return s;
}