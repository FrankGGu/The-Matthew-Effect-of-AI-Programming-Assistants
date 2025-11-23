#include <stdlib.h>

int compare(const void *a, const void *b) {
    return ((int*)b)[1] - ((int*)a)[1];
}

int maximumUnits(int** boxTypes, int boxTypesSize, int* boxTypesColSize, int truckSize) {
    qsort(boxTypes, boxTypesSize, sizeof(int*), compare);

    int totalUnits = 0;
    for (int i = 0; i < boxTypesSize; i++) {
        int numberOfBoxes = boxTypes[i][0];
        int unitsPerBox = boxTypes[i][1];

        if (truckSize == 0) {
            break;
        }

        if (numberOfBoxes <= truckSize) {
            totalUnits += numberOfBoxes * unitsPerBox;
            truckSize -= numberOfBoxes;
        } else {
            totalUnits += truckSize * unitsPerBox;
            truckSize = 0;
        }
    }

    return totalUnits;
}