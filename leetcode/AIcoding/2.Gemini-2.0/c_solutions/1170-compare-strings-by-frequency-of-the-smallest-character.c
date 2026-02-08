#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int f(char *s) {
    int count[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']++;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            return count[i];
        }
    }
    return 0;
}

int* numSmallerByFrequency(char** queries, int queriesSize, char** words, int wordsSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;
    int words_freq[wordsSize];
    for (int i = 0; i < wordsSize; i++) {
        words_freq[i] = f(words[i]);
    }
    for (int i = 0; i < queriesSize; i++) {
        int query_freq = f(queries[i]);
        int count = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (query_freq < words_freq[j]) {
                count++;
            }
        }
        result[i] = count;
    }
    return result;
}