#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxEnergyBoost(int* drinks, int drinksSize, int k) {
    int n = drinksSize;
    for (int i = 0; i < n; i++) {
        drinks[i] = drinks[i];
    }

    int energy = 0;

    for (int i = 0; i < k; i++) {
        int max_index = 0;
        for (int j = 1; j < n; j++) {
            if (drinks[j] > drinks[max_index]) {
                max_index = j;
            }
        }

        if (drinks[max_index] == 0)
            break;

        energy += drinks[max_index];
        drinks[max_index] = max(0, drinks[max_index] - 1);
    }

    return energy;
}