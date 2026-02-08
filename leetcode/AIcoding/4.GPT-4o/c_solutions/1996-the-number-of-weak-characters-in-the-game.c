int numberOfWeakCharacters(int** properties, int propertiesSize, int* propertiesColSize) {
    int count = 0;
    int maxDefense = 0;

    // Sort properties by attack in ascending order, and defense in descending order
    qsort(properties, propertiesSize, sizeof(int*), [](const void *a, const void *b) {
        int* p1 = *(int**)a;
        int* p2 = *(int**)b;
        if (p1[0] == p2[0]) {
            return p2[1] - p1[1];
        }
        return p1[0] - p2[0];
    });

    for (int i = 0; i < propertiesSize; i++) {
        if (properties[i][1] < maxDefense) {
            count++;
        } else {
            maxDefense = properties[i][1];
        }
    }

    return count;
}