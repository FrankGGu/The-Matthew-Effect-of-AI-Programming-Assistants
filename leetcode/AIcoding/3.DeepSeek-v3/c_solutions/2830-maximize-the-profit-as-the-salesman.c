typedef struct {
    int start;
    int end;
    int gold;
} Offer;

int cmp(const void* a, const void* b) {
    return ((Offer*)a)->end - ((Offer*)b)->end;
}

int maximizeTheProfit(int n, int** offers, int offersSize, int* offersColSize) {
    Offer* sortedOffers = (Offer*)malloc(offersSize * sizeof(Offer));
    for (int i = 0; i < offersSize; i++) {
        sortedOffers[i].start = offers[i][0];
        sortedOffers[i].end = offers[i][1];
        sortedOffers[i].gold = offers[i][2];
    }

    qsort(sortedOffers, offersSize, sizeof(Offer), cmp);

    int* dp = (int*)calloc(n + 1, sizeof(int));
    int offerIndex = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        while (offerIndex < offersSize && sortedOffers[offerIndex].end == i - 1) {
            int start = sortedOffers[offerIndex].start;
            int gold = sortedOffers[offerIndex].gold;
            if (dp[start] + gold > dp[i]) {
                dp[i] = dp[start] + gold;
            }
            offerIndex++;
        }
    }

    free(sortedOffers);
    free(dp);

    return dp[n];
}