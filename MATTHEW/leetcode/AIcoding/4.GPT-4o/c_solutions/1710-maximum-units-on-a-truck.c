int maximumUnits(int** boxTypes, int boxTypesSize, int* boxTypesColSize, int truckSize) {
    // Sort boxTypes based on units per box in descending order
    qsort(boxTypes, boxTypesSize, sizeof(int*), [](const void *a, const void *b) {
        return (*(int**)b)[1] - (*(int**)a)[1];
    });

    int totalUnits = 0;
    for (int i = 0; i < boxTypesSize && truckSize > 0; i++) {
        int boxes = boxTypes[i][0];
        int unitsPerBox = boxTypes[i][1];

        if (boxes <= truckSize) {
            totalUnits += boxes * unitsPerBox;
            truckSize -= boxes;
        } else {
            totalUnits += truckSize * unitsPerBox;
            truckSize = 0;
        }
    }

    return totalUnits;
}