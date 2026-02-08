#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maxCoins(int* pile, int pileSize){
    qsort(pile, pileSize, sizeof(int), compare);
    int total = 0;
    for (int i = 1; i < pileSize; i += 2) {
        total += pile[i];
    }
    return total;
}