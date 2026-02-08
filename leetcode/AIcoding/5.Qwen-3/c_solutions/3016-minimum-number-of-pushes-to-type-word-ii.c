#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumPushes(char * word) {
    int freq[26] = {0};
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        freq[word[i] - 'a']++;
    }

    qsort(freq, 26, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int pushes = 0;
    int count = 0;
    for (int i = 25; i >= 0; i--) {
        if (freq[i] == 0) continue;
        count++;
        if (count <= 8) pushes += freq[i] * 1;
        else if (count <= 16) pushes += freq[i] * 2;
        else if (count <= 24) pushes += freq[i] * 3;
        else pushes += freq[i] * 4;
    }
    return pushes;
}