#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool isNStraightHand(int* hand, int handSize, int groupSize) {
    if (handSize % groupSize != 0) {
        return false;
    }

    qsort(hand, handSize, sizeof(int), compare);

    int* seen = (int*)malloc(handSize * sizeof(int));
    for (int i = 0; i < handSize; i++) {
        seen[i] = 0;
    }

    for (int i = 0; i < handSize; i++) {
        if (seen[i] == 1) {
            continue;
        }

        int count = 1;
        seen[i] = 1;
        int last = hand[i];

        for (int j = i + 1; j < handSize; j++) {
            if (seen[j] == 0 && hand[j] == last + 1) {
                seen[j] = 1;
                last = hand[j];
                count++;
            }
            if (count == groupSize) break;
        }

        if (count != groupSize) {
            free(seen);
            return false;
        }
    }

    free(seen);
    return true;
}