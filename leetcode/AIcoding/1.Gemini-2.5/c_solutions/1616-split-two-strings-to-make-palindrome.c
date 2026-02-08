#include <string.h>
#include <stdbool.h>

static bool isPalindrome(char* s, int left, int right) {
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

static bool checkConcatenation(char* s1, char* s2) {
    int n = strlen(s1);
    int left = 0;
    int right = n - 1;

    while (left < right && s1[left] == s2[right]) {
        left++;
        right--;
    }

    return isPalindrome(s1, left, right) || isPalindrome(s2, left, right);
}

bool checkPalindromeFormation(char* a, char* b) {
    return checkConcatenation(a, b) || checkConcatenation(b, a);
}