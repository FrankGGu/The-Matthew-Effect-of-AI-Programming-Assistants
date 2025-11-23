#include <stdbool.h>
#include <string.h>

bool canMakePalindrome(char *s) {
    int count[26] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }
    int oddCount = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 != 0) {
            oddCount++;
        }
    }
    return oddCount <= 1;
}

bool* palindromeQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        char* subStr = (char*)malloc((queries[i][1] - queries[i][0] + 2) * sizeof(char));
        strncpy(subStr, s + queries[i][0], queries[i][1] - queries[i][0] + 1);
        subStr[queries[i][1] - queries[i][0] + 1] = '\0';
        result[i] = canMakePalindrome(subStr);
        free(subStr);
    }
    return result;
}