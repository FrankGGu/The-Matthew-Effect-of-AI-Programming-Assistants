#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool closeStrings(char* word1, char* word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);

    if (len1 != len2) {
        return false;
    }

    int freq1[26] = {0};
    int freq2[26] = {0};

    for (int i = 0; i < len1; i++) {
        freq1[word1[i] - 'a']++;
    }

    for (int i = 0; i < len2; i++) {
        freq2[word2[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if ((freq1[i] == 0 && freq2[i] > 0) || (freq1[i] > 0 && freq2[i] == 0)) {
            return false;
        }
    }

    int count1[26] = {0};
    int count2[26] = {0};
    int index1 = 0, index2 = 0;

    for (int i = 0; i < 26; i++) {
        if (freq1[i] > 0) {
            count1[index1++] = freq1[i];
        }
    }

    for (int i = 0; i < 26; i++) {
        if (freq2[i] > 0) {
            count2[index2++] = freq2[i];
        }
    }

    qsort(count1, index1, sizeof(int), compare);
    qsort(count2, index2, sizeof(int), compare);

    for (int i = 0; i < index1; i++) {
        if (count1[i] != count2[i]) {
            return false;
        }
    }

    return true;
}