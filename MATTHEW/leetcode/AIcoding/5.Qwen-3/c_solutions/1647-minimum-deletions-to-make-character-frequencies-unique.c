#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minDeletions(char* s) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }

    qsort(freq, 26, sizeof(int), compare);

    int deletions = 0;
    for (int i = 1; i < 26; i++) {
        if (freq[i] >= freq[i - 1]) {
            int prev = freq[i - 1];
            if (prev == 0) {
                deletions += freq[i];
            } else {
                deletions += freq[i] - prev + 1;
                freq[i] = prev - 1;
            }
        }
    }

    return deletions;
}