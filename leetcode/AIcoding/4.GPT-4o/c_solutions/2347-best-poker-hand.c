#include <stdio.h>
#include <string.h>

char* bestHand(int* ranks, int ranksSize) {
    int count[14] = {0};
    for (int i = 0; i < ranksSize; i++) {
        count[ranks[i]]++;
    }

    int maxCount = 0;
    for (int i = 1; i <= 13; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
        }
    }

    if (maxCount >= 3) return "Three of a Kind";
    if (maxCount == 2) return "One Pair";

    for (int i = 0; i < ranksSize - 1; i++) {
        if (ranks[i] % 13 == ranks[i + 1] % 13) {
            return "One Pair";
        }
    }

    return "High Card";
}