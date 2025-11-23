#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int getMaximumFruits(int* fruits, int fruitsSize, int k) {
    int n = fruitsSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + fruits[i];
    }

    int maxFruits = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int left = i;
            int right = j;
            int len = right - left + 1;
            int cost = 0;
            if (len <= k) {
                cost = len;
            } else {
                int need = len - k;
                cost = k + 2 * need;
            }
            int total = prefix[right + 1] - prefix[left];
            if (total > maxFruits) {
                maxFruits = total;
            }
        }
    }

    free(prefix);
    return maxFruits;
}