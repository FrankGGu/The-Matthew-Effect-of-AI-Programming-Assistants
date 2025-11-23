#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int pos;
    int speed;
} State;

int raceCar(int n) {
    int* dist = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    for (int i = 1; i <= n; i++) {
        int k = 1;
        while ((1 << k) - 1 < i) {
            k++;
        }
        if ((1 << k) - 1 == i) {
            dist[i] = k;
        } else {
            dist[i] = dist[i - (1 << (k - 1))] + 1 + k;
            int j = 1;
            while (j < k - 1) {
                int m = (1 << (k - 1)) - (1 << (k - 1 - j)) - 1;
                if (i - m >= 0) {
                    dist[i] = fmin(dist[i], dist[i - m] + j + 1 + k);
                }
                j++;
            }
        }
    }

    int result = dist[n];
    free(dist);
    return result;
}