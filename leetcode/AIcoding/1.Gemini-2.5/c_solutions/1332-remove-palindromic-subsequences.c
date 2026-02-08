#include <string.h>
#include <stdbool.h>

bool isPalindrome(char *s) {
    int left = 0;
    int right = strlen(s) - 1;
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

int removePalindromeSub(char *s) {
    if (s == NULL || strlen(s) == 0) {
        return 0;
    }
    if (isPalindrome(s)) {
        return 1;
    }
    return 2;
}