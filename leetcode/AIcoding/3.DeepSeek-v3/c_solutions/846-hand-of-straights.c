#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

bool isNStraightHand(int* hand, int handSize, int groupSize) {
    if (handSize % groupSize != 0) return false;

    qsort(hand, handSize, sizeof(int), cmp);

    int* used = (int*)calloc(handSize, sizeof(int));
    for (int i = 0; i < handSize; i++) {
        if (used[i]) continue;

        int current = hand[i];
        int count = 0;
        int j = i;

        while (j < handSize && count < groupSize) {
            if (!used[j] && hand[j] == current) {
                used[j] = 1;
                current++;
                count++;
                j = i;
            } else {
                j++;
            }
        }

        if (count != groupSize) {
            free(used);
            return false;
        }
    }

    free(used);
    return true;
}