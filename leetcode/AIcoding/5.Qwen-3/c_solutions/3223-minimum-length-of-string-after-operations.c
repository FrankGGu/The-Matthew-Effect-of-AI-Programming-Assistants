#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumLength(char* s) {
    int left = 0;
    int right = strlen(s) - 1;

    while (left < right && s[left] == s[right]) {
        char c = s[left];
        while (left <= right && s[left] == c) left++;
        while (left <= right && s[right] == c) right--;
    }

    return right - left + 1;
}