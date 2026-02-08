#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    int n, k;
    scanf("%d %d", &n, &k);

    int* a = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        scanf("%d", &a + i);
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (a[i] <= k) {
            count++;
            k -= a[i];
        }
    }

    free(a);
    return count;
}