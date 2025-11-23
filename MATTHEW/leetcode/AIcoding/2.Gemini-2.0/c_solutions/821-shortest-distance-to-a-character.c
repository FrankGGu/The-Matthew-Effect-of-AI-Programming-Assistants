#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* shortestToChar(char * s, char c, int* returnSize){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    int *result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int *positions = (int*)malloc(n * sizeof(int));
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == c) {
            positions[count++] = i;
        }
    }

    for (int i = 0; i < n; i++) {
        int minDist = INT_MAX;
        for (int j = 0; j < count; j++) {
            int dist = abs(i - positions[j]);
            if (dist < minDist) {
                minDist = dist;
            }
        }
        result[i] = minDist;
    }

    free(positions);
    return result;
}