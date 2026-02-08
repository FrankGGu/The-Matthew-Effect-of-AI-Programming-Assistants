#include <stdio.h>
#include <stdlib.h>

int isPalindrome(int x) {
    if (x < 0) return 0;
    int reversed = 0;
    int original = x;
    while (x > 0) {
        reversed = reversed * 10 + x % 10;
        x /= 10;
    }
    return original == reversed;
}