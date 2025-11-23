#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheNthValueAfterKSeconds(int n, int k) {
    k %= 4;
    if (k == 0) return n;
    if (k == 1) return (n == 1) ? 2 : (n == 2) ? 2 : 1;
    if (k == 2) return (n == 1) ? 1 : (n == 2) ? 2 : 2;
    return (n == 1) ? 2 : (n == 2) ? 1 : 2;
}