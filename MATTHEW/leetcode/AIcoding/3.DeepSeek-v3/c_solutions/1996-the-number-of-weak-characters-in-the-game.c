int compare(const void* a, const void* b) {
    int* aa = (int*)a;
    int* bb = (int*)b;
    if (aa[0] != bb[0]) {
        return bb[0] - aa[0];
    }
    return aa[1] - bb[1];
}

int numberOfWeakCharacters(int** properties, int propertiesSize, int* propertiesColSize) {
    qsort(properties, propertiesSize, sizeof(int*), compare);

    int maxDefense = 0;
    int count = 0;

    for (int i = 0; i < propertiesSize; i++) {
        if (properties[i][1] < maxDefense) {
            count++;
        } else {
            maxDefense = properties[i][1];
        }
    }

    return count;
}