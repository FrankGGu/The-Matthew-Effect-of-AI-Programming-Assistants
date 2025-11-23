int cmp(const void* a, const void* b) {
    long long* transA = (long long*)a;
    long long* transB = (long long*)b;
    long long diffA = transA[1] - transA[0];
    long long diffB = transB[1] - transB[0];

    if (diffA < 0 && diffB < 0) {
        return transA[1] < transB[1] ? 1 : -1;
    } else if (diffA < 0) {
        return 1;
    } else if (diffB < 0) {
        return -1;
    } else {
        return transA[0] > transB[0] ? -1 : 1;
    }
}

long long minimumMoney(long long** transactions, int transactionsSize, int* transactionsColSize) {
    qsort(transactions, transactionsSize, sizeof(long long*), cmp);

    long long money = 0;
    long long current = 0;

    for (int i = 0; i < transactionsSize; i++) {
        long long cost = transactions[i][0];
        long long cashback = transactions[i][1];

        if (current < cost) {
            money += cost - current;
            current = cost;
        }

        current -= cost;
        current += cashback;
    }

    return money;
}