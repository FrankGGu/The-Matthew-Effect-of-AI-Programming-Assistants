#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSmallestChar(char* s) {
    int freq[26] = {0};
    int minChar = 'z' + 1;
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
        if (s[i] < minChar) {
            minChar = s[i];
        }
    }
    return freq[minChar - 'a'];
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* numSmallerByFrequency(char** queries, int queriesSize, char** words, int wordsSize, int* returnSize) {
    int* wordFreq = (int*)malloc(wordsSize * sizeof(int));
    for (int i = 0; i < wordsSize; i++) {
        wordFreq[i] = countSmallestChar(words[i]);
    }
    qsort(wordFreq, wordsSize, sizeof(int), compare);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int qFreq = countSmallestChar(queries[i]);
        int left = 0, right = wordsSize;
        while (left < right) {
            int mid = (left + right) / 2;
            if (wordFreq[mid] > qFreq) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        result[i] = wordsSize - left;
    }
    *returnSize = queriesSize;
    return result;
}