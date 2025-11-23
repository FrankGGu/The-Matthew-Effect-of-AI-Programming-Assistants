#include <stdio.h>
#include <stdlib.h>

int* deckRevealedInOrder(int* deck, int deckSize, int* returnSize) {
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

    for (int j = 0; j < deckSize; j++) {
        result[temp[j]] = deck[j];
    }

    free(temp);
    free(indices);
    *returnSize = deckSize;
    return result;
}