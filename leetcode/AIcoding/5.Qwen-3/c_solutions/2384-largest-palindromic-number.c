#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestPalindromic(char* num) {
    int count[10] = {0};
    for (int i = 0; num[i]; i++) {
        count[num[i] - '0']++;
    }

    char* result = (char*)malloc(20 * sizeof(char));
    int left = 0, right = 0;
    int middle = -1;

    for (int i = 9; i >= 0; i--) {
        if (count[i] > 0) {
            if (count[i] >= 2) {
                int repeat = count[i] / 2;
                for (int j = 0; j < repeat; j++) {
                    result[left++] = i + '0';
                }
            }
            if (count[i] % 2 == 1 && middle == -1) {
                middle = i;
            }
        }
    }

    if (left == 0 && middle == -1) {
        free(result);
        return "0";
    }

    for (int i = 9; i >= 0; i--) {
        if (count[i] > 0) {
            if (count[i] >= 2) {
                int repeat = count[i] / 2;
                for (int j = 0; j < repeat; j++) {
                    result[right++] = i + '0';
                }
            }
        }
    }

    if (middle != -1) {
        result[left++] = middle + '0';
    }

    for (int i = 0; i < left; i++) {
        result[left + i] = result[left - 1 - i];
    }

    result[left + right] = '\0';

    int len = strlen(result);
    if (len == 0) {
        free(result);
        return "0";
    }

    int start = 0;
    while (start < len && result[start] == '0') {
        start++;
    }

    if (start == len) {
        free(result);
        return "0";
    }

    if (start > 0) {
        memmove(result, &result[start], len - start + 1);
    }

    return result;
}