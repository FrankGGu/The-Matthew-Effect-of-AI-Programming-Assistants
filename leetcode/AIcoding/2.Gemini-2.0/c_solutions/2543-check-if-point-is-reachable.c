#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool isReachable(int targetX, int targetY) {
    int commonDivisor = gcd(targetX, targetY);
    return (commonDivisor & (commonDivisor - 1)) == 0;
}