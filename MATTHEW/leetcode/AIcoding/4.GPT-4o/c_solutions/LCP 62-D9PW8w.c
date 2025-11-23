int minTransfers(int** transactions, int transactionsSize, int* transactionsColSize) {
    int balance[12] = {0};
    for (int i = 0; i < transactionsSize; i++) {
        balance[transactions[i][0]] -= transactions[i][2];
        balance[transactions[i][1]] += transactions[i][2];
    }

    int debts[12], debtCount = 0;
    for (int i = 0; i < 12; i++) {
        if (balance[i] != 0) {
            debts[debtCount++] = balance[i];
        }
    }

    return settle(debts, debtCount, 0, 0);
}

int settle(int* debts, int debtCount, int index, int count) {
    while (index < debtCount && debts[index] == 0) index++;
    if (index == debtCount) return count;

    int result = INT_MAX;
    for (int i = index + 1; i < debtCount; i++) {
        if (debts[i] * debts[index] < 0) {
            debts[i] += debts[index];
            result = fmin(result, settle(debts, debtCount, index + 1, count + 1));
            debts[i] -= debts[index];
        }
    }
    return result == INT_MAX ? count : result;
}