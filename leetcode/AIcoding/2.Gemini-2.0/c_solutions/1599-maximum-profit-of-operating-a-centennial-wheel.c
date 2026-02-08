#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperationsMaxProfit(int* customers, int customersSize, int boardingCost, int runningCost) {
    int waiting = 0;
    int profit = 0;
    int maxProfit = 0;
    int rotations = 0;
    int maxRotations = -1;
    int i = 0;

    while (i < customersSize || waiting > 0) {
        if (i < customersSize) {
            waiting += customers[i];
        }

        int boarding = (waiting >= 4) ? 4 : waiting;
        waiting -= boarding;

        profit += boarding * boardingCost - runningCost;
        rotations++;

        if (profit > maxProfit) {
            maxProfit = profit;
            maxRotations = rotations;
        }
        i++;
    }

    return maxRotations;
}