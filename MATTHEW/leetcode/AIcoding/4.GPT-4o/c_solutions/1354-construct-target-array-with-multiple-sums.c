#include <stdbool.h>
#include <stdlib.h>

bool isPossible(int* target, int targetSize) {
    long total = 0;
    for (int i = 0; i < targetSize; i++) {
        total += target[i];
    }
    while (true) {
        long max = 0;
        int maxIndex = -1;
        for (int i = 0; i < targetSize; i++) {
            if (target[i] > max) {
                max = target[i];
                maxIndex = i;
            }
        }
        total -= max;
        if (max == 1 || total == 0) return true;
        if (total == 0 || max <= total) return false;
        max %= total;
        total += max;
        target[maxIndex] = max;
    }
}