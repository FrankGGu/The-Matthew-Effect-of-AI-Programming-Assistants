#include <stdio.h>
#include <stdlib.h>

int pivotInteger(int n) {
    int total = n * (n + 1) / 2;
    int x = 0;
    while (x * x <= total) {
        if (x * x == total) {
            return x;
        }
        x++;
    }
    return -1;
}