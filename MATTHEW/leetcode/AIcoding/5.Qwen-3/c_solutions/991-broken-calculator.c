#include <stdio.h>
#include <stdlib.h>

int brokenCalc(int target, int start) {
    int steps = 0;
    while (start < target) {
        if (target % 2 == 1) {
            target++;
        } else {
            target /= 2;
        }
        steps++;
    }
    return steps + (start - target);
}