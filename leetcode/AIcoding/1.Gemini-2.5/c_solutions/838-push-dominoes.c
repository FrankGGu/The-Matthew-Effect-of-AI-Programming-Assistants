#include <stdlib.h>
#include <string.h>

char* pushDominoes(char* dominoes) {
    int n = strlen(dominoes);
    int* forces = (int*)calloc(n, sizeof(int));

    int force = 0;
    // Calculate forces from left to right
    for (int i = 0; i < n; i++) {
        if (dominoes[i] == 'R') {
            force = n;
        } else if (dominoes[i] == 'L') {
            force = 0;
        } else { // dominoes[i] == '.'
            if (force > 0) {
                force--;
            }
        }
        forces[i] += force;
    }

    force = 0;
    // Calculate forces from right to left
    for (int i = n - 1; i >= 0; i--) {
        if (dominoes[i] == 'L') {
            force = -n;
        } else if (dominoes[i] == 'R') {
            force = 0;
        } else { // dominoes[i] == '.'
            if (force < 0) {
                force++;
            }
        }
        forces[i] += force;
    }

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    for (int i = 0; i < n; i++) {
        if (forces[i] > 0) {
            result[i] = 'R';
        } else if (forces[i] < 0) {
            result[i] = 'L';
        } else {
            result[i] = '.';
        }
    }
    result[n] = '\0';

    free(forces);

    return result;
}