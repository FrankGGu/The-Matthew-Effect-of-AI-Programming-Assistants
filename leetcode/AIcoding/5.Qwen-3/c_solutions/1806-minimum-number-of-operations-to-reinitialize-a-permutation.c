#include <stdio.h>
#include <stdlib.h>

int reinitializePermutation(int n, int* result) {
    int* perm = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        perm[i] = i;
    }

    int ops = 0;
    int* temp = (int*)malloc(n * sizeof(int));
    int* original = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        original[i] = perm[i];
    }

    while (1) {
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                temp[i] = perm[i / 2];
            } else {
                temp[i] = perm[n / 2 + (i - 1) / 2];
            }
        }

        for (int i = 0; i < n; i++) {
            perm[i] = temp[i];
        }

        ops++;

        int equal = 1;
        for (int i = 0; i < n; i++) {
            if (perm[i] != original[i]) {
                equal = 0;
                break;
            }
        }

        if (equal) {
            *result = ops;
            free(perm);
            free(temp);
            free(original);
            return 0;
        }
    }
}