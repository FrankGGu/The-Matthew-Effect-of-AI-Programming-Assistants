#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

bool isPalindrome(long long x) {
    long long reversed = 0;
    long long original = x;
    while (x > 0) {
        reversed = reversed * 10 + x % 10;
        x /= 10;
    }
    return reversed == original;
}

int superpalindromesInRange(char* left, char* right) {
    long long L = atoll(left);
    long long R = atoll(right);
    int count = 0;

    for (long long i = 1; i <= 100000; i++) {
        char s[20];
        sprintf(s, "%lld", i);
        int len = strlen(s);

        for (int j = len - 2; j >= 0; j--) {
            s[len * 2 - 2 - j] = s[j];
        }
        s[len * 2 - 1] = '\0';
        long long pal = atoll(s);
        long long super = pal * pal;
        if (super > R) break;
        if (super >= L && isPalindrome(super)) {
            count++;
        }
    }

    for (long long i = 1; i <= 100000; i++) {
        char s[20];
        sprintf(s, "%lld", i);
        int len = strlen(s);

        for (int j = len - 1; j >= 0; j--) {
            s[len * 2 - 1 - j] = s[j];
        }
        s[len * 2] = '\0';
        long long pal = atoll(s);
        long long super = pal * pal;
        if (super > R) break;
        if (super >= L && isPalindrome(super)) {
            count++;
        }
    }

    return count;
}