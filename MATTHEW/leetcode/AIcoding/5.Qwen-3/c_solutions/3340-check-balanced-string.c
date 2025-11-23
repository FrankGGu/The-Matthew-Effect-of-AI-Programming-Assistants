#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isBalanced(char* s, int left, int right) {
    if (left >= right) return 1;
    if (s[left] != s[right]) return 0;
    return isBalanced(s, left + 1, right - 1);
}

bool check(string s) {
    return isBalanced(s, 0, strlen(s) - 1);
}