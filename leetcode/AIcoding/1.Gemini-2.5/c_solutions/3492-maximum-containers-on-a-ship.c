#include <stdlib.h> // Required for qsort

int compareBoxTypes(const void *a, const void *b) {
    const int *boxA = *(const int **)a;
    const int *boxB = *(const int **)b;
    // Compare the second element (units per box)
    return boxB[1] - boxA[1];
}

int maximumUnits(int** boxTypes, int boxTypesSize, int* boxTypesColSize, int truckSize) {
    // Sort the boxTypes array using the custom comparison function.
    // This arranges box types from most units per box to least units per box.
    qsort(boxTypes, boxTypesSize, sizeof(int*), compareBoxTypes);

    int totalUnits = 0;
    // Iterate through the sorted box types
    for (int i = 0; i < boxTypesSize && truckSize > 0; i++) {
        int numberOfBoxes = boxTypes[i][0];
        int unitsPerBox = boxTypes[i][1];

        // Determine how many boxes of the current type can be loaded.
        // It's the minimum of available boxes of this type and remaining truck capacity.
        int boxesToTake = (truckSize < numberOfBoxes) ? truckSize : numberOfBoxes;

        // Add the units from these boxes to the total.
        totalUnits += boxesToTake * unitsPerBox;
        // Decrease the remaining truck capacity.
        truckSize -= boxesToTake;
    }

    return totalUnits;
}