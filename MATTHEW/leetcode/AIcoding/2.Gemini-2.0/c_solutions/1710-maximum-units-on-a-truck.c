#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)b)[1] - ((int*)a)[1];
}

int maximumUnits(int** boxTypes, int boxTypesSize, int* boxTypesColSize, int truckSize) {
    qsort(boxTypes, boxTypesSize, sizeof(boxTypes[0]), compare);

    int totalUnits = 0;
    for (int i = 0; i < boxTypesSize; i++) {
        int numBoxes = boxTypes[i][0];
        int unitsPerBox = boxTypes[i][1];

        if (truckSize >= numBoxes) {
            totalUnits += numBoxes * unitsPerBox;
            truckSize -= numBoxes;
        } else {
            totalUnits += truckSize * unitsPerBox;
            truckSize = 0;
            break;
        }
    }

    return totalUnits;
}