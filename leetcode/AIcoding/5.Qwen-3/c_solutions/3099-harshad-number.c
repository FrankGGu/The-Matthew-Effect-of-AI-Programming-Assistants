#include <stdio.h>
#include <stdlib.h>

int isHarshad(int x) {
    int original = x;
    int sum = 0;
    while (x > 0) {
        sum += x % 10;
        x /= 10;
    }
    return (original % sum == 0) ? 1 : 0;
}