#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long gridGame(int** grid, int gridSize, int* gridColSize){
    int n = *gridColSize;
    long long top[n];
    long long bottom[n];

    top[0] = 0;
    bottom[n - 1] = 0;

    for (int i = 1; i < n; i++) {
        top[i] = top[i - 1] + grid[0][i - 1];
    }

    for (int i = n - 2; i >= 0; i--) {
        bottom[i] = bottom[i + 1] + grid[1][i + 1];
    }

    long long ans = INT64_MAX;
    for (int i = 0; i < n; i++) {
        long long current = (top[i] > bottom[i]) ? top[i] : bottom[i];
        if (current < ans) {
            ans = current;
        }
    }

    return ans;
}