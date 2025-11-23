#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumPushes(char * word) {
    int count[26] = {0};
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        count[word[i] - 'a']++;
    }

    int pushes = 0;
    int freq[26];
    for (int i = 0; i < 26; i++) {
        freq[i] = count[i];
    }

    qsort(freq, 26, sizeof(int), (int (*)(const void*, const void*))strcmp);

    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) continue;
        int pos = i + 1;
        int level = (pos - 1) / 8 + 1;
        pushes += freq[i] * level;
    }

    return pushes;
}