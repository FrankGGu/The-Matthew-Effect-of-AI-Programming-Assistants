#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfAlternatingGroups(int* past, int pastSize, int* future, int futureSize) {
    int count = 0;
    int n = pastSize;
    int m = futureSize;
    int total = n + m;
    int* combined = (int*)malloc(total * sizeof(int));

    for (int i = 0; i < n; i++) {
        combined[i] = past[i];
    }
    for (int i = 0; i < m; i++) {
        combined[n + i] = future[i];
    }

    for (int i = 0; i < total; i++) {
        int prev = combined[(i - 1 + total) % total];
        int curr = combined[i];
        int next = combined[(i + 1) % total];

        if ((prev != curr && curr != next) || (prev == curr && curr == next)) {
            count++;
        }
    }

    free(combined);
    return count;
}