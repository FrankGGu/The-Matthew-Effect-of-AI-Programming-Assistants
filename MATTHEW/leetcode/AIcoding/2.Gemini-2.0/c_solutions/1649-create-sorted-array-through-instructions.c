#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int createSortedArray(int* instructions, int instructionsSize){
    int n = 0;
    for (int i = 0; i < instructionsSize; i++) {
        if (instructions[i] > n) {
            n = instructions[i];
        }
    }
    n++;

    int* bit = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) {
        bit[i] = 0;
    }

    int mod = 1000000007;
    long long cost = 0;

    for (int i = 0; i < instructionsSize; i++) {
        int num = instructions[i];

        int less = 0;
        int greater = 0;

        int idx = num - 1;
        while (idx > 0) {
            less += bit[idx];
            idx -= (idx & -idx);
        }

        idx = num + 1;
        while (idx < n) {
            greater += bit[idx];
            idx += (idx & -idx);
        }

        cost = (cost + (less < (i - less - greater) ? less : (i - less - greater))) % mod;

        idx = num;
        while (idx < n) {
            bit[idx]++;
            idx += (idx & -idx);
        }
    }

    free(bit);
    return (int)cost;
}