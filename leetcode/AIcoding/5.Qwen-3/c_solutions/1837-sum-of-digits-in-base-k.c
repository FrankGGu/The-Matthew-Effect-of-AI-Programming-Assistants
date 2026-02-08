#include <stdio.h>
#include <stdlib.h>

int sumBase(int n, int k) {
    int sum = 0;
    while (n > 0) {
        sum += n % k;
        n /= k;
    }
    return sum;
}