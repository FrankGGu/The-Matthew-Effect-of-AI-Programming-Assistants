#include <string.h>
#include <stdbool.h>

static bool isPalindrome(char* s) {
    int len = strlen(s);
    if (len <= 1) {
        return true;
    }
    int left = 0;
    int right = len - 1;
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

char* firstPalindrome(char** words, int wordsSize) {
    for (int i = 0; i < wordsSize; i++) {
        if (isPalindrome(words[i])) {
            return words[i];
        }
    }
    return "";
}