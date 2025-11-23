#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int commonFactors(int a, int b) {
    int count = 0;
    for (int i = 1; i <= (a < b ? a : b); i++) {
        if (a % i == 0 && b % i == 0) {
            count++;
        }
    }
    return count;
}