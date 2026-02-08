#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numEquivDominoPairs(int** dominoes, int dominoesSize, int* dominoesColSize) {
    int count = 0;
    int freq[100] = {0};
    for (int i = 0; i < dominoesSize; i++) {
        int a = dominoes[i][0];
        int b = dominoes[i][1];
        int key = (a <= b) ? a * 10 + b : b * 10 + a;
        count += freq[key];
        freq[key]++;
    }
    return count;
}