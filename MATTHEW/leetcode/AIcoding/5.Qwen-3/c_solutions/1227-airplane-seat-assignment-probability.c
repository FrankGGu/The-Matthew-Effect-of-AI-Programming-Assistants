#include <stdio.h>
#include <stdlib.h>

double nthPersonGetsNthSeat(int n) {
    if (n == 1) return 1.0;
    return 1.0 / (double)n;
}