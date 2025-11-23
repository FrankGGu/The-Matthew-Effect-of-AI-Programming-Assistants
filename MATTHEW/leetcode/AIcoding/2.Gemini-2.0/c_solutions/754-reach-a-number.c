#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int reachNumber(int target) {
    target = abs(target);
    int sum = 0, steps = 0;
    while (sum < target || (sum - target) % 2 != 0) {
        steps++;
        sum += steps;
    }
    return steps;
}