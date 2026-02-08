#include <stdio.h>
#include <stdlib.h>

int minLevelsToGainMorePoints(int* s, int sSize) {
    int total = 0;
    for (int i = 0; i < sSize; i++) {
        total += s[i];
    }

    int leftSum = 0;
    int rightSum = total;
    int levels = 0;

    for (int i = 0; i < sSize; i++) {
        leftSum += s[i];
        rightSum -= s[i];
        if (leftSum > rightSum) {
            levels++;
        }
    }

    return levels;
}