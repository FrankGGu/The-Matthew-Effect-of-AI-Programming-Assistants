#include <stdlib.h>
#include <string.h>

int numEquivDominoPairs(int** dominoes, int dominoesSize, int* dominoesColSize) {
    int count[100] = {0};
    int ans = 0;

    for (int i = 0; i < dominoesSize; i++) {
        int u = dominoes[i][0];
        int v = dominoes[i][1];
        int val;
        if (u < v) {
            val = u * 10 + v;
        } else {
            val = v * 10 + u;
        }
        ans += count[val];
        count[val]++;
    }

    return ans;
}