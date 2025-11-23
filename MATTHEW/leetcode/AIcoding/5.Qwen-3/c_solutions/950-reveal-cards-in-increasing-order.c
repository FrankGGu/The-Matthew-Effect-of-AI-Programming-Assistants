#include <stdio.h>
#include <stdlib.h>

int* deckRevealedInIncreasingOrder(int* deck, int deckSize, int* returnSize) {
    int* result = (int*)malloc(deckSize * sizeof(int));
    int* indices = (int*)malloc(deckSize * sizeof(int));

    for (int i = 0; i < deckSize; i++) {
        indices[i] = i;
    }

    int* temp = (int*)malloc(deckSize * sizeof(int));
    int tempSize = 0;

    int i = 0;
    while (tempSize < deckSize) {
        if (i < deckSize) {
            temp[tempSize++] = indices[i++];
        }
        if (i < deckSize) {
            indices[i - 1] = indices[i];
            i++;
        }
    }

    for (i = 0; i < deckSize; i++) {
        indices[i] = temp[i];
    }

    free(temp);

    for (i = 0; i < deckSize; i++) {
        result[indices[i]] = deck[i];
    }

    free(indices);
    *returnSize = deckSize;
    return result;
}