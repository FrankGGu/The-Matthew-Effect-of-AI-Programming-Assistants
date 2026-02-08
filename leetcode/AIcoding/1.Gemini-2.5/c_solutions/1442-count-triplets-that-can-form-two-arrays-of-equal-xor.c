#include <stdlib.h>

int countTriplets(int* arr, int arrSize) {
    int n = arrSize;
    int* pxor = (int*)malloc((n + 1) * sizeof(int));
    pxor[0] = 0;
    for (int i = 0; i < n; i++) {
        pxor[i + 1] = pxor[i] ^ arr[i];
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int k = i; k < n; k++) {
            if (pxor[i] == pxor[k + 1]) {
                count += (k - i);
            }
        }
    }

    free(pxor);
    return count;
}