#include <stdio.h>
#include <stdlib.h>

int minimumCardPickup(int* cards, int cardsSize) {
    int min = INT_MAX;
    int* last = (int*)calloc(100001, sizeof(int));
    for (int i = 0; i < cardsSize; i++) {
        if (last[cards[i]] != 0) {
            min = (i - last[cards[i]] + 1) < min ? (i - last[cards[i]] + 1) : min;
        }
        last[cards[i]] = i + 1;
    }
    free(last);
    return min == INT_MAX ? -1 : min;
}