#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSales(int sales[], int n, int k) {
    if (n < k || k <= 0) {
        return -1;
    }

    int maxSum = 0;
    for (int i = 0; i < k; i++) {
        maxSum += sales[i];
    }

    int currentSum = maxSum;
    for (int i = k; i < n; i++) {
        currentSum += sales[i] - sales[i - k];
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
}