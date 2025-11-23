int distributeCandies(int* candies, int candiesSize) {
    int uniqueCandies = 0;
    int maxCandies = candiesSize / 2;

    for (int i = 0; i < candiesSize; i++) {
        if (candies[i] == -1) continue;
        uniqueCandies++;
        for (int j = i + 1; j < candiesSize; j++) {
            if (candies[i] == candies[j]) {
                candies[j] = -1;
            }
        }
    }

    return uniqueCandies < maxCandies ? uniqueCandies : maxCandies;
}