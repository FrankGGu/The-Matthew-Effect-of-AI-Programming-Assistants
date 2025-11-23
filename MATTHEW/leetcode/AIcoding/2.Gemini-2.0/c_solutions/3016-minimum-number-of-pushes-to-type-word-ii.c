#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumPushes(char *words) {
    int freq[26] = {0};
    int n = strlen(words);
    for (int i = 0; i < n; i++) {
        freq[words[i] - 'a']++;
    }

    int *freq_ptr[26];
    for (int i = 0; i < 26; i++) {
        freq_ptr[i] = &freq[i];
    }

    int cmp(const void *a, const void *b) {
        return -(*(int**)a - *(int**)b);
    }

    qsort(freq_ptr, 26, sizeof(int*), cmp);

    int pushes = 0;
    for (int i = 0; i < 26; i++) {
        int index = freq_ptr[i] - freq;
        if (i < 8) {
            pushes += freq[index];
        } else if (i < 20) {
            pushes += 2 * freq[index];
        } else {
            pushes += 3 * freq[index];
        }
    }

    return pushes;
}