#include <string.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minimumPushes(char * word) {
    int freq[26] = {0};
    int len = strlen(word);

    for (int i = 0; i < len; i++) {
        freq[word[i] - 'a']++;
    }

    int distinct_freqs[26];
    int distinct_count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            distinct_freqs[distinct_count++] = freq[i];
        }
    }

    qsort(distinct_freqs, distinct_count, sizeof(int), compare);

    int total_pushes = 0;
    int pushes_multiplier = 1;
    int chars_on_current_multiplier = 0;

    for (int i = 0; i < distinct_count; i++) {
        total_pushes += distinct_freqs[i] * pushes_multiplier;
        chars_on_current_multiplier++;

        if (chars_on_current_multiplier == 8) { // After 8 characters, the 9th character will use the next multiplier
            pushes_multiplier++;
            chars_on_current_multiplier = 0;
        }
    }

    return total_pushes;
}