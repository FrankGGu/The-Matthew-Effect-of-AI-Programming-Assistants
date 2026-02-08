#include <stdio.h>
#include <stdlib.h>

int minSteps(int n) {
    if (n == 1) return 0;
    int i = 2;
    while (i * i <= n) {
        if (n % i == 0) return i + minSteps(n / i);
        i++;
    }
    return n;
}