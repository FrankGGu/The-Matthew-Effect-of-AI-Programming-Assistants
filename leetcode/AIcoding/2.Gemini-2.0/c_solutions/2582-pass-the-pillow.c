#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int passThePillow(int n, int time) {
    int period = n - 1;
    int t = time % (2 * period);
    if (t < n) {
        return t + 1;
    } else {
        return n - (t - n + 1);
    }
}