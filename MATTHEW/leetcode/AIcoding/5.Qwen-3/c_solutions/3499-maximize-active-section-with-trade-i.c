#include <stdio.h>
#include <stdlib.h>

int maxActiveSections(int* trade, int tradeSize) {
    int max = 0;
    int current = 0;
    for (int i = 0; i < tradeSize; i++) {
        if (trade[i] == 1) {
            current++;
            if (current > max) {
                max = current;
            }
        } else {
            current = 0;
        }
    }
    return max;
}