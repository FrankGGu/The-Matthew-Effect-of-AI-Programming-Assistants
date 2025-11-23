#include <string.h>
#include <stdlib.h>

int compareStrings(const void* a, const void* b) {
    const char* str1 = *(const char**)a;
    const char* str2 = *(const char**)b;
    return strcmp(str1, str2);
}

int minimumOperationsToMakeKPeriodic(char* word, int k) {
    int n = strlen(word);
    int num_blocks = n / k;

    // Allocate memory for an array of char pointers to store substrings
    char** substrings = (char**)malloc(num_blocks * sizeof(char*));
    if (substrings == NULL) {
        return -1; // Memory allocation failed
    }

    // Extract and store each k-length substring
    for (int i = 0; i < num_blocks; ++i) {
        substrings[i] = (char*)malloc(k + 1); // +1 for null terminator
        if (substrings[i] == NULL) {
            // Memory allocation failed for a substring, clean up previous allocations
            for (int j = 0; j < i; ++j) {
                free(substrings[j]);
            }
            free(substrings);
            return -1;
        }
        strncpy(substrings[i], &word[i * k], k);
        substrings[i][k] = '\0'; // Null-terminate the substring
    }

    // Sort the array of substrings to easily count frequencies
    qsort(substrings, num_blocks, sizeof(char*), compareStrings);

    int max_freq = 0;
    if (num_blocks > 0) {
        max_freq = 1; // At least one block, so its frequency is at least 1
        int current_freq = 1;
        for (int i = 1; i < num_blocks; ++i) {
            if (strcmp(substrings[i], substrings[i - 1]) == 0) {
                current_freq++;
            } else {
                current_freq = 1;
            }
            if (current_freq > max_freq) {
                max_freq = current_freq;
            }
        }
    }

    // The minimum operations is the total number of blocks minus the frequency of the most common block
    int operations = num_blocks - max_freq;

    // Free allocated memory for substrings and the array of pointers
    for (int i = 0; i < num_blocks; ++i) {
        free(substrings[i]);
    }
    free(substrings);

    return operations;
}