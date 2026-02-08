#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* vowelStrings(char** words, int wordsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefix_sum = (int*)malloc(sizeof(int) * (wordsSize + 1));
    prefix_sum[0] = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        char first = words[i][0];
        char last = words[i][len - 1];
        int is_vowel_string = (first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u') &&
                              (last == 'a' || last == 'e' || last == 'i' || last == 'o' || last == 'u');
        prefix_sum[i + 1] = prefix_sum[i] + is_vowel_string;
    }

    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int start = queries[i][0];
        int end = queries[i][1];
        result[i] = prefix_sum[end + 1] - prefix_sum[start];
    }

    free(prefix_sum);
    return result;
}