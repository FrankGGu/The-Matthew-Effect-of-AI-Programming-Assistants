#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stoneGameVI(int* aliceValues, int aliceValuesSize, int* bobValues, int bobValuesSize){
    int n = aliceValuesSize;
    int values[n][3];
    for (int i = 0; i < n; i++) {
        values[i][0] = aliceValues[i] + bobValues[i];
        values[i][1] = aliceValues[i];
        values[i][2] = bobValues[i];
    }

    // Sort by the sum of aliceValues and bobValues in descending order.
    qsort(values, n, sizeof(values[0]), [](const void* a, const void* b) {
        return ((int*)b)[0] - ((int*)a)[0];
    });

    int alice_score = 0;
    int bob_score = 0;

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            alice_score += values[i][1];
        } else {
            bob_score += values[i][2];
        }
    }

    if (alice_score > bob_score) {
        return 1;
    } else if (alice_score < bob_score) {
        return -1;
    } else {
        return 0;
    }
}