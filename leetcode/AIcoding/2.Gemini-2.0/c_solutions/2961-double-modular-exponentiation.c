#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getGoodIndices(int** variables, int variablesSize, int* variablesColSize, int target, int* returnSize) {
    int* result = (int*)malloc(variablesSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < variablesSize; i++) {
        long long a = variables[i][0];
        long long b = variables[i][1];
        long long c = variables[i][2];
        long long m = variables[i][3];

        long long base1 = a % 10;
        long long exp1 = b;
        long long mod1 = 10;
        long long res1 = 1;

        while (exp1 > 0) {
            if (exp1 % 2 == 1) {
                res1 = (res1 * base1) % mod1;
            }
            base1 = (base1 * base1) % mod1;
            exp1 /= 2;
        }

        long long base2 = res1;
        long long exp2 = c;
        long long mod2 = m;
        long long res2 = 1;

        while(exp2 > 0) {
            if(exp2 % 2 == 1) {
                res2 = (res2 * base2) % mod2;
            }
            base2 = (base2 * base2) % mod2;
            exp2 /= 2;
        }

        if (res2 == target) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}