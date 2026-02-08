#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int отражение(int n, int m, int i, int j, int di, int dj, int p) {
    while (i >= 0 && i < n && j >= 0 && j < m) {
        if (i == 0 && di == -1) {
            di = 1;
            p = 0;
        } else if (i == n - 1 && di == 1) {
            di = -1;
            p = 0;
        } else if (j == 0 && dj == -1) {
            dj = 1;
            p = 1;
        } else if (j == m - 1 && dj == 1) {
            dj = -1;
            p = 1;
        }

        i += di;
        j += dj;
    }

    if (i < 0) return j;
    if (i >= n) return j;
    if (j < 0) return i;
    return i;
}