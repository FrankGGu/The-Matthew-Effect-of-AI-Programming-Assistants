#include <stdlib.h> // For qsort

int compareInts(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

long long maxProfit(int* stock, int stockSize, int* prices, int pricesSize, int k) {
    // The problem description "stock[i] quantity and prices[i] price" is ambiguous.
    // Based on common LeetCode problems with "diminishing value" (e.g., LC 1648 "Sell Diminishing-Valued Colored Balls"),
    // the most likely interpretation is that `prices[i]` represents the initial price of an item type,
    // and when an item of that type is sold, its price for subsequent sales decreases by 1.
    // The `stock` array is often either ignored or implies `stock[i]` items are available at `prices[i]`
    // before the price drops for *that specific type*.
    // However, if `stock[i]` is a large quantity, simulating each item is not feasible.
    // The most efficient approach for large `k` (orders) is to process prices in batches.
    // This solution assumes `prices` is the array of initial prices (analogous to `inventory` in LC 1648),
    // and `stock` array is effectively ignored, or `stock[i]` is implicitly 1 for each `prices[i]` type.

    // Sort prices in descending order
    qsort(prices, pricesSize, sizeof(int), compareInts);

    long long totalProfit = 0;
    long long remainingK = k;
    long long MOD = 1000000007; // Common modulo for LeetCode problems with large sums
    long long inv2 = 500000004; // Modular inverse of 2 modulo 10^9 + 7

    int idx = 0;
    long long count = 0; // Number of distinct item types whose current price is being processed or was higher

    while (remainingK > 0 && idx < pricesSize) {
        count++; // We are now considering one more item type (or a group of items at the same price)
        long long currentPrice = prices[idx];
        long long nextPrice = 0;

        // Determine the next distinct lower price. If no more distinct prices, it's 0.
        if (idx + 1 < pricesSize) {
            nextPrice = prices[idx + 1];
        }

        // Calculate how many price levels we can sell down to before hitting nextPrice (or 0).
        // We only sell positive prices.
        long long numLevelsToSell = currentPrice - nextPrice;
        if (numLevelsToSell <= 0) { // Handle cases where currentPrice <= nextPrice (e.g., duplicates)
            idx++;
            continue;
        }

        // Total items we can sell in this batch, considering all 'count' types
        // that are currently at or above 'currentPrice'.
        long long itemsInThisBatch = count * numLevelsToSell;

        if (remainingK >= itemsInThisBatch) {
            // We can sell all items in this batch (from currentPrice down to nextPrice + 1).
            // Sum of an arithmetic series: (first + last) * num_terms / 2
            // Here, first = currentPrice, last = nextPrice + 1, num_terms = numLevelsToSell
            long long startSum = currentPrice % MOD;
            long long endSum = (nextPrice + 1) % MOD;
            long long numTerms = numLevelsToSell % MOD;

            long long profitPerType = ((startSum + endSum) % MOD * numTerms) % MOD;
            profitPerType = (profitPerType * inv2) % MOD;

            totalProfit = (totalProfit + profitPerType * (count % MOD)) % MOD;
            remainingK -= itemsInThisBatch;

        } else {
            // We only sell a portion of the items in this batch, specifically 'remainingK' items.
            long long numFullDrops = remainingK / count;
            long long remainderDrops = remainingK % count;

            long long startPrice = currentPrice;
            long long endPrice = currentPrice - numFullDrops + 1;

            // Profit from full drops (each of 'count' types sells 'numFullDrops' items)
            // Prices range from startPrice down to endPrice.
            long long startSum = startPrice % MOD;
            long long endSum = endPrice % MOD;
            long long numTerms = numFullDrops % MOD;

            long long profitFromFullDrops = ((startSum + endSum) % MOD * numTerms) % MOD;
            profitFromFullDrops = (profitFromFullDrops * inv2) % MOD;

            totalProfit = (totalProfit + profitFromFullDrops * (count % MOD)) % MOD;

            // Profit from remainder drops (selling 'remainderDrops' items at 'endPrice - 1')
            // Ensure (endPrice - 1) is not negative before modulo, as prices cannot be negative.
            long long remainderPrice = (endPrice - 1);
            if (remainderPrice > 0) {
                totalProfit = (totalProfit + (remainderPrice % MOD * (remainderDrops % MOD))) % MOD;
            }

            remainingK = 0; // All k items sold
        }
        idx++;
    }

    return totalProfit;
}