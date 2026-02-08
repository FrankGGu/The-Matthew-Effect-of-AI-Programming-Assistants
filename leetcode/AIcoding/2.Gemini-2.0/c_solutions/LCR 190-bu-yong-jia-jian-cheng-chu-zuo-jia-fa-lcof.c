#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int encrypt(int a, int b) {
    int res = 0;
    int p = 1;
    while (a > 0 || b > 0) {
        int digitA = a % 10;
        int digitB = b % 10;
        int sum = (digitA + digitB) % 10;
        res += sum * p;
        p *= 10;
        a /= 10;
        b /= 10;
    }
    return res;
}