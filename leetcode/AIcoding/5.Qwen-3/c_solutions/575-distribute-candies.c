#include <stdio.h>
#include <stdlib.h>

int distributeCandies(int* candyType, int candyTypeSize) {
    int uniqueCandies = 0;
    int* seen = (int*)malloc(candyTypeSize * sizeof(int));

    for (int i = 0; i < candyTypeSize; i++) {
        int isUnique = 1;
        for (int j = 0; j < uniqueCandies; j++) {
            if (candyType[i] == seen[j]) {
                isUnique = 0;
                break;
            }
        }
        if (isUnique) {
            seen[uniqueCandies++] = candyType[i];
        }
    }

    free(seen);
    return (uniqueCandies < candyTypeSize / 2) ? uniqueCandies : candyTypeSize / 2;
}