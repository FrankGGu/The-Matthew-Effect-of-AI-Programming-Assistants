#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTotalTrips(char* time) {
    int n = strlen(time);
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    int* suffix = (int*)malloc((n + 1) * sizeof(int));

    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + (time[i] == 'N' ? 1 : 0);
    }

    suffix[n] = 0;
    for (int i = n - 1; i >= 0; i--) {
        suffix[i] = suffix[i + 1] + (time[i] == 'N' ? 1 : 0);
    }

    int minPenalty = INT_MAX;
    for (int i = 0; i <= n; i++) {
        int penalty = prefix[i] + suffix[i];
        if (penalty < minPenalty) {
            minPenalty = penalty;
        }
    }

    free(prefix);
    free(suffix);
    return minPenalty;
}