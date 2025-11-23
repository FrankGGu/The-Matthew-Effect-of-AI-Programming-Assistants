#include <stdio.h>
#include <stdlib.h>

int minDominoRotations(int* tops, int n, int* bottoms, int m) {
    int countTop[7] = {0};
    int countBot[7] = {0};
    int same[7] = {0};

    for (int i = 0; i < n; i++) {
        countTop[tops[i]]++;
        countBot[bottoms[i]]++;
        if (tops[i] == bottoms[i]) {
            same[tops[i]]++;
        }
    }

    for (int i = 1; i <= 6; i++) {
        if (countTop[i] + countBot[i] - same[i] == n) {
            return n - countTop[i];
        }
    }

    return -1;
}