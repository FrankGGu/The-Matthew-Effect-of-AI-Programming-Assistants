#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* closestDivisors(int num, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int minDiff = INT_MAX;
    int a = 0, b = 0;

    for (int i = sqrt(num); i >= 1; i--) {
        if (num % i == 0) {
            a = i;
            b = num / i;
            break;
        }
    }

    for (int i = sqrt(num + 1); i >= 1; i--) {
        if ((num + 1) % i == 0) {
            int currA = i;
            int currB = (num + 1) / i;
            if (abs(currA - currB) < minDiff) {
                minDiff = abs(currA - currB);
                a = currA;
                b = currB;
            }
            break;
        }
    }

    for (int i = sqrt(num + 2); i >= 1; i--) {
        if ((num + 2) % i == 0) {
            int currA = i;
            int currB = (num + 2) / i;
            if (abs(currA - currB) < minDiff) {
                minDiff = abs(currA - currB);
                a = currA;
                b = currB;
            }
            break;
        }
    }

    result[0] = a;
    result[1] = b;
    *returnSize = 2;
    return result;
}