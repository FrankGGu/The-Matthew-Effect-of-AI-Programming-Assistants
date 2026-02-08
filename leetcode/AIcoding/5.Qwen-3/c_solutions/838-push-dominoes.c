#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* pushDominoes(char* dominoes) {
    int n = strlen(dominoes);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int* left = (int*)calloc(n, sizeof(int));
    int* right = (int*)calloc(n, sizeof(int));

    int time = 0;
    for (int i = 0; i < n; i++) {
        if (dominoes[i] == 'R') {
            time = 1;
        } else if (dominoes[i] == 'L') {
            time = 0;
        } else {
            right[i] = time;
        }
    }

    time = 0;
    for (int i = n - 1; i >= 0; i--) {
        if (dominoes[i] == 'L') {
            time = 1;
        } else if (dominoes[i] == 'R') {
            time = 0;
        } else {
            left[i] = time;
        }
    }

    for (int i = 0; i < n; i++) {
        if (right[i] > left[i]) {
            result[i] = 'R';
        } else if (left[i] > right[i]) {
            result[i] = 'L';
        } else {
            result[i] = '.';
        }
    }
    result[n] = '\0';
    free(left);
    free(right);
    return result;
}