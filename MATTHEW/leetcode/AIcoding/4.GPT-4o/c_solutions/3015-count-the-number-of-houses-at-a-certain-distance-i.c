int countHouses(int *houses, int housesSize, int distance) {
    int count = 0;
    for (int i = 0; i < housesSize; i++) {
        for (int j = 0; j < housesSize; j++) {
            if (i != j && abs(houses[i] - houses[j]) == distance) {
                count++;
            }
        }
    }
    return count / 2;
}