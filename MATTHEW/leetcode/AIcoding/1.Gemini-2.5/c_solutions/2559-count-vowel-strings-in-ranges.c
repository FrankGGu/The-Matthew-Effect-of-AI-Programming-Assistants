#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int* vowelStrings(char** words, int wordsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefixSums = (int*)malloc((wordsSize + 1) * sizeof(int));
    prefixSums[0] = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        if (len > 0 && isVowel(word[0]) && isVowel(word[len - 1])) {
            prefixSums[i + 1] = prefixSums[i] + 1;
        } else {
            prefixSums[i + 1] = prefixSums[i];
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int start = queries[i][0];
        int end = queries[i][1];
        result[i] = prefixSums[end + 1] - prefixSums[start];
    }

    free(prefixSums);
    return result;
}