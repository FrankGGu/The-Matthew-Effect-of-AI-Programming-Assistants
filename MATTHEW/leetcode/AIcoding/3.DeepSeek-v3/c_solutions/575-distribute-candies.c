int distributeCandies(int* candyType, int candyTypeSize) {
    int maxTypes = candyTypeSize / 2;
    bool types[200001] = {false};
    int uniqueCount = 0;

    for (int i = 0; i < candyTypeSize; i++) {
        int type = candyType[i] + 100000;
        if (!types[type]) {
            types[type] = true;
            uniqueCount++;
            if (uniqueCount >= maxTypes) {
                return maxTypes;
            }
        }
    }

    return uniqueCount;
}