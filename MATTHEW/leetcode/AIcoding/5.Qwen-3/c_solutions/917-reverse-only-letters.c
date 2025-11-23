#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverseOnlyLetters(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int left = 0, right = len - 1;

    while (left < right) {
        if ((s[left] >= 'a' && s[left] <= 'z') || (s[left] >= 'A' && s[left] <= 'Z')) {
            if ((s[right] >= 'a' && s[right] <= 'z') || (s[right] >= 'A' && s[right] <= 'Z')) {
                result[left++] = s[right];
                result[right--] = s[left];
            } else {
                right--;
            }
        } else {
            result[left++] = s[left];
        }
    }

    if (left == right) {
        result[left] = s[left];
    }

    result[len] = '\0';
    return result;
}