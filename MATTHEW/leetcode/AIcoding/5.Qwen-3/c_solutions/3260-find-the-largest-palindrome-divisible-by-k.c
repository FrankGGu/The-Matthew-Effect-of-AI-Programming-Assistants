#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

long long largestPalindrome(int n, int k) {
    if (n == 1) return 9;

    int max = pow(10, n) - 1;
    int min = pow(10, n - 1);

    for (int i = max; i >= min; i--) {
        char s[20];
        sprintf(s, "%d", i);
        char rev[20];
        strcpy(rev, s);
        strrev(rev);
        long long pal = atoll(strcat(s, rev));
        if (pal % k == 0) return pal;
    }

    return -1;
}