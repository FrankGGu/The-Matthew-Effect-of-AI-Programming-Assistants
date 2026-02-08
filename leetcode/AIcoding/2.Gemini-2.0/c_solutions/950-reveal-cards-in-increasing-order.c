#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* deckRevealedIncreasing(int* deck, int deckSize, int* returnSize) {
    qsort(deck, deckSize, sizeof(int), cmpfunc);

    int* result = (int*)malloc(sizeof(int) * deckSize);
    *returnSize = deckSize;

    int* indexQueue = (int*)malloc(sizeof(int) * deckSize);
    int head = 0;
    int tail = deckSize;

    for (int i = 0; i < deckSize; i++) {
        indexQueue[i] = i;
    }

    for (int i = 0; i < deckSize; i++) {
        result[indexQueue[head++]] = deck[i];

        if (head < deckSize) {
            indexQueue[tail++] = indexQueue[head++];
        }
    }

    free(indexQueue);
    return result;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}