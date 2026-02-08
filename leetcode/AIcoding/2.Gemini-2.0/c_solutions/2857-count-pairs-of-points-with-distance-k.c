#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPairs(int** coordinates, int coordinatesSize, int* coordinatesColSize, int k) {
    int count = 0;
    for (int i = 0; i < coordinatesSize; i++) {
        for (int j = i + 1; j < coordinatesSize; j++) {
            if (abs(coordinates[i][0] - coordinates[j][0]) + abs(coordinates[i][1] - coordinates[j][1]) == k) {
                count++;
            }
        }
    }
    return count;
}