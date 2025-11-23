typedef struct {
    int start;
    int end;
    int tip;
} Ride;

int cmp(const void* a, const void* b) {
    return ((Ride*)a)->end - ((Ride*)b)->end;
}

long long maxTaxiEarnings(int n, int** rides, int ridesSize, int* ridesColSize) {
    Ride* sortedRides = (Ride*)malloc(ridesSize * sizeof(Ride));
    for (int i = 0; i < ridesSize; i++) {
        sortedRides[i].start = rides[i][0];
        sortedRides[i].end = rides[i][1];
        sortedRides[i].tip = rides[i][2];
    }

    qsort(sortedRides, ridesSize, sizeof(Ride), cmp);

    long long* dp = (long long*)calloc(n + 1, sizeof(long long));
    int idx = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        while (idx < ridesSize && sortedRides[idx].end == i) {
            long long earn = sortedRides[idx].end - sortedRides[idx].start + sortedRides[idx].tip;
            dp[i] = (dp[i] > dp[sortedRides[idx].start] + earn) ? dp[i] : dp[sortedRides[idx].start] + earn;
            idx++;
        }
    }

    long long result = dp[n];
    free(sortedRides);
    free(dp);
    return result;
}