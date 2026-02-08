#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int storeWater(int* bucket, int bucketSize, int* vat, int vatSize) {
    int max_vat = 0;
    for (int i = 0; i < vatSize; i++) {
        if (vat[i] > max_vat) {
            max_vat = vat[i];
        }
    }
    if (max_vat == 0) {
        return 0;
    }

    int min_ops = 1e9;
    for (int k = 1; k <= max_vat; k++) {
        int ops = k;
        for (int i = 0; i < vatSize; i++) {
            int num = (vat[i] + k - 1) / k;
            ops += (num > bucket[i] ? num - bucket[i] : 0);
        }
        if (ops < min_ops) {
            min_ops = ops;
        }
    }

    return min_ops;
}