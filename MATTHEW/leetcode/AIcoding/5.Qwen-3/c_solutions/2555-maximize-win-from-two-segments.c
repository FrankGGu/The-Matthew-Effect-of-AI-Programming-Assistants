#include <stdio.h>
#include <stdlib.h>

int maximizeWin(int* rewards, int rewardsSize, int k) {
    int n = rewardsSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + rewards[i];
    }

    int maxWin = 0;
    for (int i = 0; i < n; ++i) {
        int left = i;
        int right = i + k - 1;
        if (right >= n) continue;
        int current = prefix[right + 1] - prefix[left];
        for (int j = 0; j < n; ++j) {
            if (j <= left - 1) {
                int win = prefix[left] - prefix[j];
                maxWin = (maxWin > win + current) ? maxWin : win + current;
            }
            if (j >= right + 1) {
                int win = prefix[j] - prefix[right + 1];
                maxWin = (maxWin > win + current) ? maxWin : win + current;
            }
        }
    }

    free(prefix);
    return maxWin;
}