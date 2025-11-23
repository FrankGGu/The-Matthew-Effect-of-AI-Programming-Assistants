#include <stdbool.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool isNStraightHand(int* hand, int handSize, int W) {
    if (handSize % W != 0) return false;

    qsort(hand, handSize, sizeof(int), cmp);

    int* count = (int*)calloc(10000, sizeof(int));

    for (int i = 0; i < handSize; i++) {
        count[hand[i]]++;
    }

    for (int i = 0; i < handSize; i++) {
        if (count[hand[i]] > 0) {
            for (int j = 0; j < W; j++) {
                if (count[hand[i] + j] == 0) {
                    free(count);
                    return false;
                }
                count[hand[i] + j]--;
            }
        }
    }

    free(count);
    return true;
}