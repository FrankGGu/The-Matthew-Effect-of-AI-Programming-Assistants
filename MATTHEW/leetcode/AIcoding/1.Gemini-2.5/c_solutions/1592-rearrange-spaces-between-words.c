#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char * reorderSpaces(char * text) {
    int len = strlen(text);

    // Arrays to store pointers to the start of each word and their lengths
    char *word_ptrs[100]; 
    int word_lengths[100];
    int word_idx = 0;
    int space_count = 0;

    int i = 0;
    while (i < len) {
        // Count spaces
        while (i < len && text[i] == ' ') {
            space_count++;
            i++;
        }

        // If a word starts
        if (i < len) {
            word_ptrs[word_idx] = &text[i];
            int word_start = i;
            while (i < len && text[i] != ' ') {
                i++;
            }
            word_lengths[word_idx] = i - word_start;
            word_idx++;
        }
    }

    int num_words = word_idx;

    int spaces_per_gap = 0;
    int trailing_spaces = 0;

    if (num_words == 0) { // Case with only spaces, e.g., "   "
        spaces_per_gap = 0;
        trailing_spaces = space_count;
    } else if (num_words == 1) { // Case with one word, all spaces go to the end
        spaces_per_gap = 0;
        trailing_spaces = space_count;
    } else { // Multiple words, distribute spaces
        spaces_per_gap = space_count / (num_words - 1);
        trailing_spaces = space_count % (num_words - 1);
    }

    // Allocate memory for the result string
    char *result = (char *)malloc(sizeof(char) * (len + 1));
    if (result == NULL) {
        return NULL; // Handle malloc failure
    }

    int current_pos = 0;

    for (int w = 0; w < num_words; w++) {
        // Copy word
        strncpy(result + current_pos, word_ptrs[w], word_lengths[w]);
        current_pos += word_lengths[w];

        // Add spaces between words if not the last word and there are multiple words
        if (w < num_words - 1) { 
            for (int s = 0; s < spaces_per_gap; s++) {
                result[current_pos++] = ' ';
            }
        }
    }

    // Add any remaining trailing spaces
    for (int s = 0; s < trailing_spaces; s++) {
        result[current_pos++] = ' ';
    }

    result[current_pos] = '\0'; // Null-terminate the result string

    return result;
}