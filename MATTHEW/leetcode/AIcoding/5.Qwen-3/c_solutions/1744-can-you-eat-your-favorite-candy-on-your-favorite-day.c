#include <stdio.h>
#include <stdlib.h>

bool canEat(int* candyType, int candyTypeSize, int k, int day) {
    int uniqueCandies = 0;
    int* seen = (int*)malloc(candyTypeSize * sizeof(int));
    for (int i = 0; i < candyTypeSize; i++) {
        int found = 0;
        for (int j = 0; j < uniqueCandies; j++) {
            if (seen[j] == candyType[i]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            seen[uniqueCandies++] = candyType[i];
        }
    }
    free(seen);
    return (day < uniqueCandies && k >= uniqueCandies);
}