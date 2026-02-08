int canComplete(int n, int m, int* gain, int* loss) {
    int totalGain = 0, totalLoss = 0;
    for (int i = 0; i < n; i++) {
        totalGain += gain[i];
        totalLoss += loss[i];
    }
    return totalGain >= totalLoss && totalGain - totalLoss <= m;
}