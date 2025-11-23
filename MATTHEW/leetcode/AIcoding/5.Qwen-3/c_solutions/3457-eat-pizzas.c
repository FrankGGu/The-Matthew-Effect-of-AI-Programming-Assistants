#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxSatisfaction(int* satisfaction, int satisfactionSize) {
    int i, j;
    int n = satisfactionSize;
    int total = 0;
    int sum = 0;
    int res = 0;

    for (i = n - 1; i >= 0; i--) {
        sum += satisfaction[i];
        if (sum > 0) {
            res += sum;
        } else {
            break;
        }
    }

    return res;
}