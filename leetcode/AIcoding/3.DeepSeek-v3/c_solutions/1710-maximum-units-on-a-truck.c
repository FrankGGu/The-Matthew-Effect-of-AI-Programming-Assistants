int compare(const void* a, const void* b) {
    int* boxA = *(int**)a;
    int* boxB = *(int**)b;
    return boxB[1] - boxA[1];
}

int maximumUnits(int** boxTypes, int boxTypesSize, int* boxTypesColSize, int truckSize) {
    qsort(boxTypes, boxTypesSize, sizeof(int*), compare);

    int units = 0;
    int boxes = 0;

    for (int i = 0; i < boxTypesSize && boxes < truckSize; i++) {
        int numBoxes = boxTypes[i][0];
        int numUnits = boxTypes[i][1];

        int take = (boxes + numBoxes <= truckSize) ? numBoxes : truckSize - boxes;
        units += take * numUnits;
        boxes += take;
    }

    return units;
}