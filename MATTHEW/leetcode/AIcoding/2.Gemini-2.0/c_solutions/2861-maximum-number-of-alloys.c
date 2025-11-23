#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAlloys(int n, int k, int budget, int** composition, int* stock, int* cost, int compositionSize, int* compositionColSize) {
    int low = 0, high = 2000000000, ans = 0;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        int possible = 0;
        for (int i = 0; i < n; i++) {
            long long need = 0;
            for (int j = 0; j < k; j++) {
                need += (long long)composition[i][j] * mid;
                need -= stock[j];
            }
            long long money = 0;
            if (need > 0) {
                for (int j = 0; j < k; j++) {
                    money += (long long)fmax(0, (long long)composition[i][j] * mid - stock[j]) * cost[j];
                }
            }

            if (money <= budget) {
                possible = 1;
                break;
            }
        }
        if (possible) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}