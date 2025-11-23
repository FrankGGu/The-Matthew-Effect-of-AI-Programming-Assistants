#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int integerReplacement(int n) {
    if (n == 1) return 0;
    if (n == INT_MAX) return 32;

    int count = 0;
    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            if ((n + 1) % 4 == 0 && n != 3) {
                n++;
            } else {
                n--;
            }
        }
        count++;
    }
    return count;
}