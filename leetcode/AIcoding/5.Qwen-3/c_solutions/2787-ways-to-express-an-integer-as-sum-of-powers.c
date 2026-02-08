#include <stdio.h>
#include <stdlib.h>

int count = 0;

void dfs(int n, int power, int start, int target) {
    if (target == 0) {
        count++;
        return;
    }
    if (target < 0) {
        return;
    }
    for (int i = start; i <= n; i++) {
        int val = 1;
        for (int j = 0; j < power; j++) {
            val *= i;
            if (val > target) break;
        }
        if (val > target) break;
        dfs(n, power, i + 1, target - val);
    }
}

int numberOfWays(int n, int k) {
    count = 0;
    dfs(n, k, 1, n);
    return count;
}