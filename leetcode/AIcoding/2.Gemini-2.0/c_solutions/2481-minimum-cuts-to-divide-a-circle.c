#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfCuts(int n) {
    if (n == 1) return 1;
    if (n % 2 == 0) return n / 2;
    else {
        if (n == 0) return 0;
        return n;
    }
}