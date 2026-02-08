#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canSplit(char* a, char* b) {
    int left = 0;
    int right = strlen(a) - 1;

    while (left < right) {
        if (a[left] != b[right]) break;
        left++;
        right--;
    }

    if (left >= right) return true;

    left = 0;
    right = strlen(a) - 1;

    while (left < right) {
        if (b[left] != a[right]) break;
        left++;
        right--;
    }

    return left >= right;
}

bool checkPalindromeFormation(char* a, char* b) {
    return canSplit(a, b) || canSplit(b, a);
}