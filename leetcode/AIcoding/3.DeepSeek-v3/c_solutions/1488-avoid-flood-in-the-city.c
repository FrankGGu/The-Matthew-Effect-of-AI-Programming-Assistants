/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* avoidFlood(int* rains, int rainsSize, int* returnSize) {
    int *ans = (int*)malloc(rainsSize * sizeof(int));
    *returnSize = rainsSize;

    for (int i = 0; i < rainsSize; i++) {
        ans[i] = -1;
    }

    int *fullLakes = (int*)calloc(100001, sizeof(int));
    int *lastRain = (int*)calloc(100001, sizeof(int));

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            if (fullLakes[rains[i]] == 1) {
                free(ans);
                free(fullLakes);
                free(lastRain);
                *returnSize = 0;
                return NULL;
            }
            fullLakes[rains[i]] = 1;
            lastRain[rains[i]] = i;
            ans[i] = -1;
        }
    }

    for (int i = 0; i < 100001; i++) {
        fullLakes[i] = 0;
        lastRain[i] = -1;
    }

    int *dryDays = (int*)malloc(rainsSize * sizeof(int));
    int dryCount = 0;

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] == 0) {
            dryDays[dryCount++] = i;
            ans[i] = 1;
        }
    }

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            int lake = rains[i];
            if (fullLakes[lake] == 1) {
                int found = 0;
                for (int j = 0; j < dryCount; j++) {
                    if (dryDays[j] > lastRain[lake] && dryDays[j] < i) {
                        ans[dryDays[j]] = lake;
                        dryDays[j] = -1;
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    free(ans);
                    free(fullLakes);
                    free(lastRain);
                    free(dryDays);
                    *returnSize = 0;
                    return NULL;
                }
            }
            fullLakes[lake] = 1;
            lastRain[lake] = i;
        }
    }

    free(fullLakes);
    free(lastRain);
    free(dryDays);
    return ans;
}