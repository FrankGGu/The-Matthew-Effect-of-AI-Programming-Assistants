int distributeCandies(int* candyType, int candyTypeSize) {
    int uniqueCandies = 0;
    for (int i = 0; i < candyTypeSize; i++) {
        if (candyType[i] == -1) continue;
        uniqueCandies++;
        for (int j = i + 1; j < candyTypeSize; j++) {
            if (candyType[j] == candyType[i]) {
                candyType[j] = -1;
            }
        }
    }
    int maxCandies = candyTypeSize / 2;
    return uniqueCandies < maxCandies ? uniqueCandies : maxCandies;
}