#include <stdbool.h>
#include <stdlib.h>

bool canArrange(int* arr, int arrSize, int k) {
    int* counts = (int*)calloc(k, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        int remainder = arr[i] % k;
        if (remainder < 0) {
            remainder += k;
        }
        counts[remainder]++;
    }

    if (counts[0] % 2 != 0) {
        free(counts);
        return false;
    }

    for (int i = 1; i <= k / 2; i++) {
        if (i == k - i) { // This condition is true when k is even and i is k/2
            if (counts[i] % 2 != 0) {
                free(counts);
                return false;
            }
        } else {
            if (counts[i] != counts[k - i]) {
                free(counts);
                return false;
            }
        }
    }

    free(counts);
    return true;
}