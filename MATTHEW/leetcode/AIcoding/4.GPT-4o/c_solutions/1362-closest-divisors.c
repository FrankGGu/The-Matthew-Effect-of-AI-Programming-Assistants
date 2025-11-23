#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int* closestDivisors(int num, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int closestPair[2] = {1, num + 1};
    *returnSize = 2;

    for (int i = (int)sqrt(num + 1); i >= 1; i--) {
        if ((num + 1) % i == 0) {
            closestPair[0] = i;
            closestPair[1] = (num + 1) / i;
            break;
        }
    }

    for (int i = (int)sqrt(num + 2); i >= 1; i--) {
        if ((num + 2) % i == 0) {
            if (abs(i - (num + 2) / i) < abs(closestPair[0] - closestPair[1])) {
                closestPair[0] = i;
                closestPair[1] = (num + 2) / i;
            }
            break;
        }
    }

    result[0] = closestPair[0];
    result[1] = closestPair[1];
    return result;
}