int giveGem(int* gem, int gemSize, int** operations, int operationsSize, int* operationsColSize) {
    for (int i = 0; i < operationsSize; i++) {
        int x = operations[i][0];
        int y = operations[i][1];
        int give = gem[x] / 2;
        gem[x] -= give;
        gem[y] += give;
    }

    int max = gem[0];
    int min = gem[0];
    for (int i = 1; i < gemSize; i++) {
        if (gem[i] > max) max = gem[i];
        if (gem[i] < min) min = gem[i];
    }

    return max - min;
}