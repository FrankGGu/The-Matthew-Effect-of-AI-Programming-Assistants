#include <string.h>

int minimumLength(char *s) {
    int left = 0, right = strlen(s) - 1;
    while (left < right) {
        if (s[left] == s[right]) {
            char c = s[left];
            while (left <= right && s[left] == c) left++;
            while (left <= right && s[right] == c) right--;
        } else {
            break;
        }
    }
    return right - left + 1;
}