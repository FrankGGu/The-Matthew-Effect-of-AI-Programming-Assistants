#include <stdlib.h> // For qsort
#include <string.h> // For strlen
#include <stdbool.h> // For bool

int compareIntegers(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minDeletions(char * s) {
    int freq_counts[26] = {0};
    int len = strlen(s);

    // 1. Count character frequencies
    for (int i = 0; i < len; i++) {
        freq_counts[s[i] - 'a']++;
    }

    // 2. Collect non-zero frequencies into an array
    int freqs[26];
    int num_unique_chars = 0;
    for (int i = 0; i < 26; i++) {
        if (freq_counts[i] > 0) {
            freqs[num_unique_chars++] = freq_counts[i];
        }
    }

    // 3. Sort frequencies in descending order
    qsort(freqs, num_unique_chars, sizeof(int), compareIntegers);

    // 4. Use a boolean array to track used frequencies
    // Max possible frequency is 'len' (10^5)
    // The problem constraints state s.length() <= 10^5, so index 100000 is possible.
    // Array size 100001 covers indices from 0 to 100000.
    bool used_frequencies[100001] = {false}; 
    int operations = 0;

    // 5. Iterate through sorted frequencies and adjust
    for (int i = 0; i < num_unique_chars; i++) {
        int current_freq = freqs[i];

        // While this frequency is already used and it's not 0
        while (current_freq > 0 && used_frequencies[current_freq]) {
            current_freq--;
            operations++;
        }

        // If current_freq is greater than 0, mark it as used
        // If it becomes 0, it means the character is effectively removed,
        // and its frequency doesn't need to be tracked as unique.
        if (current_freq > 0) {
            used_frequencies[current_freq] = true;
        }
    }

    return operations;
}