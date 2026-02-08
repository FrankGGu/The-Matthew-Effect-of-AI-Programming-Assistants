#include <string.h>
#include <stdio.h> // For NULL, not strictly needed for LeetCode but good practice

int lengthLongestPath(char * input) {
    // path_lengths[i] stores the length of the path up to the directory/file at depth i.
    // The maximum possible depth can be roughly the length of the input string (e.g., "a\n\tb\n\t\tc...").
    // Given input length up to 10000, an array of size 10001 is sufficient for depths 0 to 10000.
    int path_lengths[10001];
    int max_len = 0;
    int n = strlen(input);
    int i = 0;

    while (i < n) {
        int current_depth = 0;
        int current_name_len = 0;
        int is_file = 0;

        // Calculate depth by counting leading '\t' characters
        while (i < n && input[i] == '\t') {
            current_depth++;
            i++;
        }

        // Calculate name length and check if it's a file (contains '.')
        while (i < n && input[i] != '\n') {
            if (input[i] == '.') {
                is_file = 1;
            }
            current_name_len++;
            i++;
        }

        // Calculate the absolute path length for the current entry
        int current_path_len;
        if (current_depth == 0) {
            // Root level entry, path length is just its name length
            current_path_len = current_name_len;
        } else {
            // For nested entries, add the parent's path length, 1 for the '/' separator, and current name length
            current_path_len = path_lengths[current_depth - 1] + 1 + current_name_len;
        }

        // Store the calculated path length at the current depth.
        // This effectively "updates" the path for the current branch at this depth.
        path_lengths[current_depth] = current_path_len;

        // If the current entry is a file, compare its absolute path length with max_len
        if (is_file) {
            if (current_path_len > max_len) {
                max_len = current_path_len;
            }
        }

        // Move past the '\n' character to the beginning of the next line, if it exists
        if (i < n && input[i] == '\n') {
            i++;
        }
    }

    return max_len;
}