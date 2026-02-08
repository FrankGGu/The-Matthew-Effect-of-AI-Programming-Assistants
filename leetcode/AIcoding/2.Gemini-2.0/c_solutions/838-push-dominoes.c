#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * pushDominoes(char * dominoes) {
    int n = 0;
    while (dominoes[n] != '\0') {
        n++;
    }

    int forces[n];
    for (int i = 0; i < n; i++) {
        forces[i] = 0;
    }

    int force = 0;
    for (int i = 0; i < n; i++) {
        if (dominoes[i] == 'R') {
            force = n;
        } else if (dominoes[i] == 'L') {
            force = 0;
        } else {
            force = (force > 0) ? (force - 1) : 0;
        }
        forces[i] += force;
    }

    force = 0;
    for (int i = n - 1; i >= 0; i--) {
        if (dominoes[i] == 'L') {
            force = n;
        } else if (dominoes[i] == 'R') {
            force = 0;
        } else {
            force = (force > 0) ? (force - 1) : 0;
        }
        forces[i] -= force;
    }

    for (int i = 0; i < n; i++) {
        if (forces[i] > 0) {
            dominoes[i] = 'R';
        } else if (forces[i] < 0) {
            dominoes[i] = 'L';
        }
    }

    return dominoes;
}