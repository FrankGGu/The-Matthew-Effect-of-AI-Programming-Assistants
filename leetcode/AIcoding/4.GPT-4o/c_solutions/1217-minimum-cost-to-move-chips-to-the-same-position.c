int minCostToMoveChips(int* chips, int chipsSize) {
    int oddCount = 0, evenCount = 0;
    for (int i = 0; i < chipsSize; i++) {
        if (chips[i] % 2 == 0) {
            evenCount++;
        } else {
            oddCount++;
        }
    }
    return oddCount < evenCount ? oddCount : evenCount;
}