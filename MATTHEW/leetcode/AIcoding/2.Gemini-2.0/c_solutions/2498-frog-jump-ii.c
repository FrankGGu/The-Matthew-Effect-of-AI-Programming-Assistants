#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int frogJump(int* stones, int stonesSize) {
    int ans = 0;
    for (int i = 1; i < stonesSize; i++) {
        ans = max(ans, stones[i] - stones[i - 1]);
    }
    return 2 * ans;
}