#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int binaryGap(int n) {
    int lastBit = -1;
    int maxGap = 0;
    for (int i = 0; n > 0; i++) {
        if (n % 2 == 1) {
            if (lastBit != -1) {
                int gap = i - lastBit;
                if (gap > maxGap) {
                    maxGap = gap;
                }
            }
            lastBit = i;
        }
        n /= 2;
    }
    return maxGap;
}