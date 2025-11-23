#include <stdio.h>
#include <stdlib.h>

int xorSum(int* a, int n, int* b, int m) {
    int result = 0;
    for (int i = 0; i < 32; i++) {
        int countA = 0;
        int countB = 0;
        for (int j = 0; j < n; j++) {
            if (a[j] & (1 << i)) countA++;
        }
        for (int j = 0; j < m; j++) {
            if (b[j] & (1 << i)) countB++;
        }
        if ((countA * countB) % 2 == 1) {
            result |= (1 << i);
        }
    }
    return result;
}