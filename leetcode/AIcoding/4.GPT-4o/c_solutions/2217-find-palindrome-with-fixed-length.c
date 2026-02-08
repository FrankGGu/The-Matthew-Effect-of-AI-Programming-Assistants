#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool isPalindrome(char *s) {
    int left = 0, right = strlen(s) - 1;
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

char *findPalindrome(int n) {
    if (n <= 0) return "";

    int start = n == 1 ? 0 : (int)pow(10, (n - 1) / 2);
    int end = (int)pow(10, (n + 1) / 2);

    for (int i = start; i < end; i++) {
        char str[20];
        sprintf(str, "%d", i);
        char rev[20];
        int len = strlen(str);

        for (int j = 0; j < len; j++) {
            rev[len - j - 1] = str[j];
        }
        rev[len] = '\0';

        char *palindrome = (char *)malloc(2 * len + 1);
        if (n % 2 == 0) {
            sprintf(palindrome, "%s%s", str, rev);
        } else {
            sprintf(palindrome, "%s%s", str, rev + 1);
        }

        if (isPalindrome(palindrome)) {
            return palindrome;
        }
        free(palindrome);
    }

    return "";
}