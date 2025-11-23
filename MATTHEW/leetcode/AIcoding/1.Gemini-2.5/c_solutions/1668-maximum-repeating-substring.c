#include <string.h>
#include <stdlib.h>

int maxRepeating(char * sequence, char * word){
    int count = 0;
    int len_s = strlen(sequence);
    int len_w = strlen(word);

    // The maximum length of the repeated word we need to check is len_s + len_w.
    // If the repeated word exceeds len_s, strstr will return NULL.
    // We need space for the string and the null terminator.
    char *repeated_word = (char *)malloc(len_s + len_w + 1);
    if (repeated_word == NULL) {
        return 0; // Handle allocation failure, though unlikely for small sizes
    }
    repeated_word[0] = '\0'; // Initialize as an empty string

    while (1) {
        // Append word to the current repeated_word
        strcat(repeated_word, word);

        // Check if the current repeated_word is a substring of sequence
        if (strstr(sequence, repeated_word) != NULL) {
            count++;
        } else {
            // If not found, the previous count was the maximum
            break;
        }

        // Optimization: if repeated_word becomes longer than sequence,
        // it can no longer be a substring.
        if (strlen(repeated_word) > len_s) {
            break;
        }
    }

    free(repeated_word);
    return count;
}