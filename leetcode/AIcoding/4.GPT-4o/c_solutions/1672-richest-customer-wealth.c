int maximumWealth(int** accounts, int accountsSize, int* accountsColSize) {
    int maxWealth = 0;
    for (int i = 0; i < accountsSize; i++) {
        int currentWealth = 0;
        for (int j = 0; j < accountsColSize[i]; j++) {
            currentWealth += accounts[i][j];
        }
        if (currentWealth > maxWealth) {
            maxWealth = currentWealth;
        }
    }
    return maxWealth;
}