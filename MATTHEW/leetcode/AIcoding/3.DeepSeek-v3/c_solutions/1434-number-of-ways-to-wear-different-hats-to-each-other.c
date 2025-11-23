int numberWays(int** hats, int hatsSize, int* hatsColSize) {
    int n = hatsSize;
    int mod = 1e9 + 7;

    int maxHatId = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < hatsColSize[i]; j++) {
            if (hats[i][j] > maxHatId) {
                maxHatId = hats[i][j];
            }
        }
    }

    int hatCount = maxHatId;

    int** hatToPerson = (int**)malloc((hatCount + 1) * sizeof(int*));
    int* hatToPersonSize = (int*)calloc(hatCount + 1, sizeof(int));

    for (int i = 0; i <= hatCount; i++) {
        hatToPerson[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < hatsColSize[i]; j++) {
            int hat = hats[i][j];
            hatToPerson[hat][hatToPersonSize[hat]++] = i;
        }
    }

    int totalStates = 1 << n;
    int* dp = (int*)malloc(totalStates * sizeof(int));
    for (int i = 0; i < totalStates; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int hat = 1; hat <= hatCount; hat++) {
        for (int state = totalStates - 1; state >= 0; state--) {
            for (int k = 0; k < hatToPersonSize[hat]; k++) {
                int person = hatToPerson[hat][k];
                int personMask = 1 << person;
                if ((state & personMask) == 0) {
                    int newState = state | personMask;
                    dp[newState] = (dp[newState] + dp[state]) % mod;
                }
            }
        }
    }

    int result = dp[totalStates - 1];

    for (int i = 0; i <= hatCount; i++) {
        free(hatToPerson[i]);
    }
    free(hatToPerson);
    free(hatToPersonSize);
    free(dp);

    return result;
}