#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minCostII(int* costs, int costsSize, int k) {
    int prev = 0;
    int min1 = 0;
    int min2 = 0;

    for (int i = 0; i < costsSize; i++) {
        int curr = i + 1;
        int newMin1 = INT_MAX;
        int newMin2 = INT_MAX;

        for (int j = 0; j < k; j++) {
            if (j != prev) {
                int cost = costs[i * k + j] + (j == prev ? min2 : min1);
                if (cost < newMin1) {
                    newMin2 = newMin1;
                    newMin1 = cost;
                } else if (cost < newMin2) {
                    newMin2 = cost;
                }
            }
        }

        prev = curr;
        min1 = newMin1;
        min2 = newMin2;
    }

    return min1;
}