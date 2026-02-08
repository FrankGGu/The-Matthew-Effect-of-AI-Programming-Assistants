#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * kthSmallestPath(int* destination, int destinationSize, int k){
    int vertical = destination[0];
    int horizontal = destination[1];
    int total = vertical + horizontal;
    char *result = (char*)malloc(sizeof(char) * (total + 1));
    result[total] = '\0';
    int h = horizontal;
    int v = vertical;
    long long comb[31][31];
    memset(comb, 0, sizeof(comb));
    for (int i = 0; i <= 30; i++) {
        comb[i][0] = 1;
        comb[i][i] = 1;
    }
    for (int i = 2; i <= 30; i++) {
        for (int j = 1; j < i; j++) {
            comb[i][j] = comb[i - 1][j - 1] + comb[i - 1][j];
        }
    }

    for (int i = 0; i < total; i++) {
        if (h > 0) {
            long long combinations = comb[v + h - 1][v];
            if (k <= combinations) {
                result[i] = 'H';
                h--;
            } else {
                result[i] = 'V';
                k -= combinations;
                v--;
            }
        } else {
            result[i] = 'V';
            v--;
        }
    }
    return result;
}