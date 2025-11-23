#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getWinner(int* arr, int arrSize, int k) {
    if (k >= arrSize - 1) {
        int maxVal = arr[0];
        for (int i = 1; i < arrSize; i++) {
            if (arr[i] > maxVal) {
                maxVal = arr[i];
            }
        }
        return maxVal;
    }

    int winner = arr[0];
    int winCount = 0;

    for (int i = 1; i < arrSize; i++) {
        if (winner > arr[i]) {
            winCount++;
        } else {
            winner = arr[i];
            winCount = 1;
        }

        if (winCount == k) {
            return winner;
        }
    }

    return winner;
}