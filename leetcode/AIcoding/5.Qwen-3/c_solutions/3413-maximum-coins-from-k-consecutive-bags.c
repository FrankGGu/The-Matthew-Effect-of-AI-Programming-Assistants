#include <stdio.h>
#include <stdlib.h>

int maxCoins(int* piles, int pilesSize, int k) {
    int* temp = (int*)malloc(pilesSize * sizeof(int));
    for (int i = 0; i < pilesSize; i++) {
        temp[i] = piles[i];
    }

    for (int i = 0; i < pilesSize - 1; i++) {
        for (int j = 0; j < pilesSize - i - 1; j++) {
            if (temp[j] > temp[j + 1]) {
                int t = temp[j];
                temp[j] = temp[j + 1];
                temp[j + 1] = t;
            }
        }
    }

    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += temp[pilesSize - 2 - i];
    }

    free(temp);
    return sum;
}