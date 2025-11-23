#include <stdlib.h> // Required for qsort

int compareBuildings(const void* a, const void* b) {
    const int* buildingA = *(const int**)a;
    const int* buildingB = *(const int**)b;

    // Sort by x-coordinate in descending order
    if (buildingA[0] != buildingB[0]) {
        return buildingB[0] - buildingA[0];
    }
    // If x-coordinates are equal, sort by y-coordinate in ascending order
    return buildingA[1] - buildingB[1];
}

int countCoveredBuildings(int** buildings, int buildingsSize, int* buildingsColSize) {
    if (buildingsSize == 0) {
        return 0;
    }

    // Sort the buildings array using the custom comparison function.
    // This arranges buildings such that we process those with larger x-coordinates first.
    // For buildings with the same x-coordinate, we process those with smaller y-coordinates first.
    qsort(buildings, buildingsSize, sizeof(int*), compareBuildings);

    int count = 0;
    // maxY keeps track of the maximum y-coordinate encountered among the buildings
    // that have been determined to be "not covered" so far.
    // Initialize to -1, as y-coordinates are non-negative (0 <= yi <= 10^9).
    int maxY = -1; 

    // Iterate through the sorted buildings.
    for (int i = 0; i < buildingsSize; ++i) {
        int currentY = buildings[i][1];

        // A building (currentX, currentY) is considered "not covered" if its y-coordinate
        // is greater than or equal to the maximum y-coordinate (maxY) of any building
        // processed before it that could potentially cover it.
        //
        // Due to sorting:
        // 1. All buildings processed before the current one (index j < i) have x_j >= currentX.
        // 2. If x_j == currentX, then y_j <= currentY (due to y-ascending sort for ties).
        //    In this case, building j cannot cover building i.
        // 3. If x_j > currentX, then building j could potentially cover building i if y_j >= currentY.
        //    The `maxY` variable stores the maximum y_j among all such buildings j that were
        //    themselves not covered.
        //
        // Therefore, if currentY >= maxY, it means the current building is not covered by any
        // building processed so far. We count it and update maxY.
        if (currentY >= maxY) {
            count++;
            maxY = currentY; // Update maxY to include the current building's y-coordinate
        }
    }

    return count;
}