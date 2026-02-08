#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int pivotInteger(int n) {
    int totalSum = (n * (n + 1)) / 2;
    int leftSum = 0;
    for (int i = 1; i <= n; i++) {
        leftSum += i;
        if (leftSum == totalSum - leftSum + i) {
            return i;
        }
    }
    return -1;
}