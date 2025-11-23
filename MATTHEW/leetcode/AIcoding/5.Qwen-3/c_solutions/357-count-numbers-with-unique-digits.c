#include <stdio.h>
#include <stdlib.h>

int countNumbersWithUniqueDigits(int n) {
    if (n == 0) return 1;
    if (n > 10) n = 10;
    int total = 10;
    int unique = 9;
    for (int i = 1; i < n; i++) {
        unique *= (10 - i);
        total += unique;
    }
    return total;
}