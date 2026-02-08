#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool* getMagicTriplet(int n, int* resultSize) {
    bool* res = (bool*)malloc(n * sizeof(bool));
    for (int i = 0; i < n; i++) {
        res[i] = false;
    }
    *resultSize = 0;
    return res;
}