double averageWaitingTime(int** customers, int customersSize, int* customersColSize) {
    long long totalWaitTime = 0, currentTime = 0;

    for (int i = 0; i < customersSize; i++) {
        currentTime += customers[i][0];
        totalWaitTime += currentTime - customers[i][1];
    }

    return (double)totalWaitTime / customersSize;
}