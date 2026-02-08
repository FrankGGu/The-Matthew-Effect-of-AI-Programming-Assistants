#include <stdio.h>
#include <stdlib.h>

int smallestValue(int n) {
    if (n <= 2) return n;

    int sum = 0;
    while (n > 1) {
        for (int i = 2; i <= n; i++) {
            if (n % i == 0) {
                sum += i;
                n /= i;
                break;
            }
        }
    }
    return sum;
}