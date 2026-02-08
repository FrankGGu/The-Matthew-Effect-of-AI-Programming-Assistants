#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* constructPalindrome(int* count, int len, char* result) {
    int mid = -1;
    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 == 1) {
            mid = i;
            break;
        }
    }

    int idx = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            int half = count[i] / 2;
            for (int j = 0; j < half; j++) {
                result[idx++] = 'a' + i;
            }
        }
    }

    if (mid != -1) {
        result[idx++] = 'a' + mid;
    }

    for (int i = 25; i >= 0; i--) {
        if (count[i] > 0) {
            int half = count[i] / 2;
            for (int j = 0; j < half; j++) {
                result[idx++] = 'a' + i;
            }
        }
    }

    return result;
}

char* makeSmallestPalindrome(char* s) {
    int len = strlen(s);
    int* count = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    result[len] = '\0';

    return constructPalindrome(count, len, result);
}