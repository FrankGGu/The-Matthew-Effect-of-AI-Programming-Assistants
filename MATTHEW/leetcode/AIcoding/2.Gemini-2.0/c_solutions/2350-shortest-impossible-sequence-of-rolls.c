#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestSequence(int* rolls, int rollsSize, int k) {
    int count = 1;
    int seen[100001] = {0};
    int uniqueCount = 0;

    for (int i = 0; i < rollsSize; i++) {
        if (rolls[i] <= k && seen[rolls[i]] == 0) {
            seen[rolls[i]] = 1;
            uniqueCount++;
        }
        if (uniqueCount == k) {
            count++;
            for (int j = 1; j <= k; j++) {
                seen[j] = 0;
            }
            uniqueCount = 0;
        }
    }

    return count;
}