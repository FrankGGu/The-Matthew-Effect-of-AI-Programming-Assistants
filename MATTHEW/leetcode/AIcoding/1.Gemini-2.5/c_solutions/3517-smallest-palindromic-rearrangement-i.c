#include <stdlib.h>
#include <string.h>

char* smallestPalindromicRearrangement(char* s) {
    if (s == NULL) {
        char* empty = (char*)malloc(1);
        if (empty == NULL) return NULL;
        empty[0] = '\0';
        return empty;
    }

    int len = strlen(s);
    if (len == 0) {
        char* empty = (char*)malloc(1);
        if (empty == NULL) return NULL;
        empty[0] = '\0';
        return empty;
    }

    int freq[26] = {0};
    for (int i = 0; i < len; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            freq[s[i] - 'a']++;
        }
    }

    char middleChar = '\0';
    int oddCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            oddCount++;
            middleChar = (char)('a' + i);
        }
    }

    if (oddCount > 1) {
        char* empty = (char*)malloc(1);
        if (empty == NULL) return NULL;
        empty[0] = '\0';
        return empty;
    }

    char* result = (char*)malloc(len + 1);
    if (result == NULL) {
        return NULL;
    }
    char* current = result;

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < freq[i] / 2; j++) {
            *current++ = (char)('a' + i);
        }
    }

    char* firstHalfEnd = current;

    if (middleChar != '\0') {
        *current++ = middleChar;
    }

    char* ptr = firstHalfEnd - 1;
    while (ptr >= result) {
        *current++ = *ptr--;
    }

    *current = '\0';

    return result;
}