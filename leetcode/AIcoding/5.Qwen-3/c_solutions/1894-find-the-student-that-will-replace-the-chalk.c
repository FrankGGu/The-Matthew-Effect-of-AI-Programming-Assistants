#include <stdio.h>
#include <stdlib.h>

int chalkReplacer(int* chalks, int chalksSize, int k) {
    long long total = 0;
    for (int i = 0; i < chalksSize; i++) {
        total += chalks[i];
    }
    k %= total;
    for (int i = 0; i < chalksSize; i++) {
        if (k < chalks[i]) {
            return i;
        }
        k -= chalks[i];
    }
    return -1;
}