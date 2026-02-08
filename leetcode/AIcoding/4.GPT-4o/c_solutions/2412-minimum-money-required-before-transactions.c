int minMoney(int** transactions, int transactionsSize, int* transactionsColSize) {
    int total = 0, maxDebt = 0;
    for (int i = 0; i < transactionsSize; i++) {
        total += transactions[i][1];
        if (transactions[i][1] < 0) {
            maxDebt += -transactions[i][1];
        }
    }
    return total + maxDebt;
}