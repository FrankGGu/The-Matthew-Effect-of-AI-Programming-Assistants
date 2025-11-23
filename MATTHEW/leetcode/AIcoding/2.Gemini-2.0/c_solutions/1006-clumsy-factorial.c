#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int clumsy(int N) {
    if (N == 1) return 1;
    if (N == 2) return 2;
    if (N == 3) return 6;
    int res = N * (N - 1) / (N - 2) + (N - 3);
    N -= 4;
    while (N > 0) {
        if (N == 1) {
            res -= N;
            break;
        }
        if (N == 2) {
            res -= N * (N - 1);
            break;
        }
        if (N == 3) {
            res -= N * (N - 1) / (N - 2);
            break;
        }
        res -= N * (N - 1) / (N - 2) - (N - 3);
        N -= 4;
    }
    return res;
}