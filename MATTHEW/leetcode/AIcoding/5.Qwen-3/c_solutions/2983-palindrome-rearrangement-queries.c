#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canFormPalindrome(char *s, int *count) {
    int freq[26] = {0};
    for (int i = 0; s[i]; i++) {
        freq[s[i] - 'a']++;
    }
    int oddCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            oddCount++;
        }
    }
    return oddCount <= 1;
}

bool* canMakePaliQueries(char** queries, int queriesSize, int* resultsSize) {
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        char* s = queries[i];
        int count[26] = {0};
        for (int j = 0; s[j]; j++) {
            count[s[j] - 'a']++;
        }
        int odd = 0;
        for (int j = 0; j < 26; j++) {
            if (count[j] % 2 != 0) {
                odd++;
            }
        }
        result[i] = (odd <= 1);
    }
    *resultsSize = queriesSize;
    return result;
}