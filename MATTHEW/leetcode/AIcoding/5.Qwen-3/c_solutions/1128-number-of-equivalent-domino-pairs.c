#include <stdio.h>
#include <stdlib.h>

int numEquivalentPairs(int** dominoes, int dominoesSize, int* dominoesColSize) {
    int count[10][10] = {0};
    int result = 0;

    for (int i = 0; i < dominoesSize; i++) {
        int a = dominoes[i][0];
        int b = dominoes[i][1];
        if (a > b) {
            int temp = a;
            a = b;
            b = temp;
        }
        count[a][b]++;
    }

    for (int i = 1; i <= 9; i++) {
        for (int j = 1; j <= 9; j++) {
            int n = count[i][j];
            result += n * (n - 1) / 2;
        }
    }

    return result;
}