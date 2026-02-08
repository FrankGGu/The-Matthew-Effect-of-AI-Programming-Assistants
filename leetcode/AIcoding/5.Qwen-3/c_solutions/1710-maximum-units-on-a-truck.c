#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int maximumUnits(int** boxTypes, int boxTypesSize, int* boxTypesColSize, int truckSize) {
    qsort(boxTypes, boxTypesSize, sizeof(int*), compare);
    int totalUnits = 0;
    int boxesTaken = 0;

    for (int i = 0; i < boxTypesSize && boxesTaken < truckSize; i++) {
        int boxes = boxTypes[i][1];
        int unitsPerBox = boxTypes[i][0];
        int take = (truckSize - boxesTaken) < boxes ? (truckSize - boxesTaken) : boxes;
        totalUnits += take * unitsPerBox;
        boxesTaken += take;
    }

    return totalUnits;
}