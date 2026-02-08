#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * bestHand(int * ranks, int ranksSize, char * suits, int suitsSize) {
    int suit_same = 1;
    for (int i = 1; i < suitsSize; i++) {
        if (suits[i] != suits[0]) {
            suit_same = 0;
            break;
        }
    }
    if (suit_same) return "Flush";

    int counts[14] = {0};
    for (int i = 0; i < ranksSize; i++) {
        counts[ranks[i]]++;
    }

    int max_count = 0;
    for (int i = 1; i <= 13; i++) {
        if (counts[i] > max_count) {
            max_count = counts[i];
        }
    }

    if (max_count >= 3) return "Three of a Kind";
    if (max_count == 2) return "Pair";
    return "High Card";
}