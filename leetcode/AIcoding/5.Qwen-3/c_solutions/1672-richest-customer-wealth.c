#include <stdio.h>
#include <stdlib.h>

int maximumWealth(int** accounts, int accountsSize, int* accountsColSize) {
    int maxWealth = 0;
    for (int i = 0; i < accountsSize; i++) {
        int total = 0;
        for (int j = 0; j < accountsColSize[i]; j++) {
            total += accounts[i][j];
        }
        if (total > maxWealth) {
            maxWealth = total;
        }
    }
    return maxWealth;
}