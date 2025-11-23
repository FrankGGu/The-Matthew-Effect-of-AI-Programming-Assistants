#define MAX(a,b) ((a) > (b) ? (a) : (b))

double minTimeToFinishRace(int* tires, int tiresSize, int changeTime, int numLaps) {
    double minTime = 1e18;
    double* dp = (double*)malloc((numLaps + 1) * sizeof(double));

    for (int i = 0; i <= numLaps; i++) {
        dp[i] = 1e18;
    }

    dp[0] = 0;

    for (int i = 1; i <= numLaps; i++) {
        for (int j = 0; j < tiresSize; j++) {
            long long total = 0;
            double time = 0;
            for (int k = 1; k <= i; k++) {
                total += 1LL << (k - 1);
                if (total > i) break;
                time += tires[j] * (1 << (k - 1));
                dp[i] = MIN(dp[i], dp[i - total] + time + changeTime);
            }
        }
        dp[i] = MIN(dp[i], dp[i - 1] + changeTime + tires[0]);
    }

    minTime = dp[numLaps];
    free(dp);
    return minTime;
}