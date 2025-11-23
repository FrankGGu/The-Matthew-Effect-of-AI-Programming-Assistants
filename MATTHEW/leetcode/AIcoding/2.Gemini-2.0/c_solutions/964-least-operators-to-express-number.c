#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int leastOpsExpressTarget(int x, int target) {
    int pos[41];
    int neg[41];
    pos[0] = neg[0] = INT_MAX / 2;
    pos[1] = 1 + min(target, abs(target - x));
    neg[1] = 1 + min(target + x, abs(target));

    for (int i = 2; i < 41; i++) {
        int p = target % x;
        target /= x;
        pos[i] = min(i * p + pos[i - 1], (i + 1) * (x - p) + neg[i - 1]);
        neg[i] = min(i * (x - p) + pos[i - 1], (i + 1) * p + neg[i - 1]);
    }

    return min(pos[40], neg[40] + 40) - 1;
}