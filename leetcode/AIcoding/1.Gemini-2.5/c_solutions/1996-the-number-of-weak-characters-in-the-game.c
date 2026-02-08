#include <stdlib.h>

int compareProperties(const void* a, const void* b) {
    const int* propA = *(const int**)a;
    const int* propB = *(const int**)b;

    if (propA[0] != propB[0]) {
        return propA[0] - propB[0];
    } else {
        return propB[1] - propA[1];
    }
}

int numberOfWeakCharacters(int** properties, int propertiesSize, int* propertiesColSize) {
    qsort(properties, propertiesSize, sizeof(int*), compareProperties);

    int weakCharactersCount = 0;
    int maxDefenseSeenSoFar = 0;

    for (int i = propertiesSize - 1; i >= 0; --i) {
        int currentDefense = properties[i][1];

        if (currentDefense < maxDefenseSeenSoFar) {
            weakCharactersCount++;
        }

        if (currentDefense > maxDefenseSeenSoFar) {
            maxDefenseSeenSoFar = currentDefense;
        }
    }

    return weakCharactersCount;
}