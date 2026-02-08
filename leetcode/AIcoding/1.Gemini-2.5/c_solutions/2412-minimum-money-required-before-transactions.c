#include <stdlib.h> // For qsort

int compareTransactions(const void* a, const void* b) {
    const int* t1 = *(const int**)a;
    const int* t2 = *(const int**)b;

    // Calculate the net change in money for each transaction: cost - cashback
    // A positive value means a loss, a non-positive value means a gain or neutral.
    long long d1 = (long long)t1[0] - t1[1];
    long long d2 = (long long)t2[0] - t2[1];

    // Rule: Transactions that result in a gain or are neutral (d <= 0) should generally
    // be performed before transactions that result in a loss (d > 0).

    // Case 1: Both transactions are gainers/neutral (d <= 0)
    if (d1 <= 0 && d2 <= 0) {
        // Among gainers/neutral, prioritize those with smaller cost.
        // This allows us to satisfy smaller initial requirements first,
        // potentially leaving more money for subsequent transactions.
        return t1[0] - t2[0];
    }
    // Case 2: Both transactions are losers (d > 0)
    else if (d1 > 0 && d2 > 0) {
        // Among losers, prioritize those with smaller net loss (smaller d).
        // This minimizes the money drained from our balance,
        // making it easier to afford subsequent transactions.
        if (d1 < d2) return -1;
        if (d1 > d2) return 1;
        return 0; // If net losses are equal, their relative order doesn't affect the overall minimum money.
    }
    // Case 3: t1 is a gainer/neutral (d1 <= 0), t2 is a loser (d2 > 0)
    else if (d1 <= 0 && d2 > 0) {
        return -1; // t1 should come before t2
    }
    // Case 4: t1 is a loser (d1 > 0), t2 is a gainer/neutral (d2 <= 0)
    else { // d1 > 0 && d2 <= 0
        return 1; // t1 should come after t2
    }
}

long long minimumMoney(int** transactions, int transactionsSize, int* transactionsColSize) {
    // Sort the transactions according to the custom comparator
    qsort(transactions, transactionsSize, sizeof(int*), compareTransactions);

    long long min_initial_money = 0; // The minimum initial money required
    long long current_money = 0;     // The money we currently have after some transactions

    for (int i = 0; i < transactionsSize; i++) {
        long long cost = transactions[i][0];
        long long cashback = transactions[i][1];

        // If our current money is less than the cost required for the current transaction,
        // we need to "top up" our balance. This top-up must come from the initial money.
        if (current_money < cost) {
            long long needed_from_initial = cost - current_money;
            min_initial_money += needed_from_initial;
            current_money += needed_from_initial; // Our current money effectively becomes 'cost'
        }

        // Perform the transaction: deduct cost and add cashback
        current_money += (cashback - cost);
    }

    return min_initial_money;
}