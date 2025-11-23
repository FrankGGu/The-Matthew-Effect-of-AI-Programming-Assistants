#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    int n, m;
    scanf("%d %d", &n, &m);
    int a[n];
    int b[m];
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }
    for (int i = 0; i < m; i++) {
        scanf("%d", &b[i]);
    }

    int count = 0;
    int j = 0;
    for (int i = 0; i < n; i++) {
        if (j < m && a[i] == b[j]) {
            count++;
            j++;
        }
    }
    return count;
}