#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* supplyWagon(int* supplies, int suppliesSize, int* returnSize) {
    while (suppliesSize > suppliesSize / 2 * 2) {
        int minSum = supplies[0] + supplies[1];
        int minIndex = 0;
        for (int i = 1; i < suppliesSize - 1; i++) {
            if (supplies[i] + supplies[i + 1] < minSum) {
                minSum = supplies[i] + supplies[i + 1];
                minIndex = i;
            }
        }
        supplies[minIndex] = minSum;
        for (int i = minIndex + 1; i < suppliesSize - 1; i++) {
            supplies[i] = supplies[i + 1];
        }
        suppliesSize--;
    }
    *returnSize = suppliesSize;
    return supplies;
}