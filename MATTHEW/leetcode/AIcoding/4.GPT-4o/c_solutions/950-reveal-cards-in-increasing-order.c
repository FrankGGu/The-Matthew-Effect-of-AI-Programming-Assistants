#include <stdlib.h>

int* deckRevealedIncreasing(int* deck, int deckSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * deckSize);
    int* indices = (int*)malloc(sizeof(int) * deckSize);
    for (int i = 0; i < deckSize; i++) {
        indices[i] = i;
    }

    qsort(deck, deckSize, sizeof(int), cmp);

    int j = 0;
    for (int i = 0; i < deckSize; i++) {
        result[indices[j]] = deck[i];
        j++;
        if (j < deckSize) {
            indices[j] = indices[j - 1];
            j++;
        }
    }

    free(indices);
    *returnSize = deckSize;
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}