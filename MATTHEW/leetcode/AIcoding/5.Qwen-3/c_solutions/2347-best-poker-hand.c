#include <stdio.h>
#include <stdlib.h>

char* bestHand(int* ranks, int ranksSize, char* suits, int suitsSize) {
    int count[13] = {0};
    int maxCount = 0;
    for (int i = 0; i < ranksSize; i++) {
        count[ranks[i] - 1]++;
        if (count[ranks[i] - 1] > maxCount) {
            maxCount = count[ranks[i] - 1];
        }
    }

    int isFlush = 1;
    for (int i = 1; i < suitsSize; i++) {
        if (suits[i] != suits[0]) {
            isFlush = 0;
            break;
        }
    }

    if (isFlush) {
        return "Flush";
    }

    if (maxCount >= 4) {
        return "Four of a Kind";
    } else if (maxCount == 3) {
        return "Three of a Kind";
    } else if (maxCount == 2) {
        return "Pair";
    } else {
        return "High Card";
    }
}