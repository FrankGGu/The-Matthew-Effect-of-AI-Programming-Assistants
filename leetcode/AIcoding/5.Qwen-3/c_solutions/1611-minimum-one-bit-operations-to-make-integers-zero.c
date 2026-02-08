#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int minimumOneBitOperations(int n) {
    if (n == 0) return 0;
    int k = 0;
    while ((1 << k) <= n) k++;
    k--;
    return (1 << k) - minimumOneBitOperations(n - (1 << k));
}