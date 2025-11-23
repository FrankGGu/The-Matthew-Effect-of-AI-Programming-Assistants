#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maximumBobPoints(int numArrows, int* aliceArrows, int aliceArrowsSize, int* returnSize){
    int* bobArrows = (int*)malloc(sizeof(int) * aliceArrowsSize);
    *returnSize = aliceArrowsSize;

    int maxScore = -1;
    int bestMask = -1;

    for (int mask = 0; mask < (1 << aliceArrowsSize); mask++) {
        int arrowsUsed = 0;
        int score = 0;
        for (int i = 0; i < aliceArrowsSize; i++) {
            if (mask & (1 << i)) {
                arrowsUsed += aliceArrows[i] + 1;
                score += i;
            }
        }

        if (arrowsUsed <= numArrows) {
            if (score > maxScore) {
                maxScore = score;
                bestMask = mask;
            }
        }
    }

    memset(bobArrows, 0, sizeof(int) * aliceArrowsSize);
    int arrowsUsed = 0;
    for (int i = 0; i < aliceArrowsSize; i++) {
        if (bestMask & (1 << i)) {
            bobArrows[i] = aliceArrows[i] + 1;
            arrowsUsed += bobArrows[i];
        }
    }

    bobArrows[0] += (numArrows - arrowsUsed);

    return bobArrows;
}