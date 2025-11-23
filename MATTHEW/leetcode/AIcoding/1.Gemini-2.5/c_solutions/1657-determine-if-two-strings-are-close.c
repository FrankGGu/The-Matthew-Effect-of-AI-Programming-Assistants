#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool closeStrings(char * word1, char * word2){
    int len1 = strlen(word1);
    int len2 = strlen(word2);

    if (len1 != len2) {
        return false;
    }

    int freq1[26] = {0};
    int freq2[26] = {0};

    for (int i = 0; i < len1; i++) {
        freq1[word1[i] - 'a']++;
        freq2[word2[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if ((freq1[i] > 0 && freq2[i] == 0) || (freq1[i] == 0 && freq2[i] > 0)) {
            return false;
        }
    }

    qsort(freq1, 26, sizeof(int), compareInt);
    qsort(freq2, 26, sizeof(int), compareInt);

    for (int i = 0; i < 26; i++) {
        if (freq1[i] != freq2[i]) {
            return false;
        }
    }

    return true;
}