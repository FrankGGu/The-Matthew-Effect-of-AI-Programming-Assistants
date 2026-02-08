#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* closestDivisors(int num, int* returnSize){
    int a = num + 1;
    int b = num + 2;

    int bestA = 1;
    int bestB = a;
    int minDiff = a - 1;

    for (int i = (int)sqrt(a); i >= 1; i--) {
        if (a % i == 0) {
            int j = a / i;
            if (abs(i - j) < minDiff) {
                minDiff = abs(i - j);
                bestA = i;
                bestB = j;
            }
            break;
        }
    }

    for (int i = (int)sqrt(b); i >= 1; i--) {
        if (b % i == 0) {
            int j = b / i;
            if (abs(i - j) < minDiff) {
                minDiff = abs(i - j);
                bestA = i;
                bestB = j;
            }
            break;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = bestA;
    result[1] = bestB;
    *returnSize = 2;
    return result;
}