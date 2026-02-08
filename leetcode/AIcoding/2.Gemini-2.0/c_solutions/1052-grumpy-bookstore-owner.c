#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSatisfied(int* customers, int customersSize, int* grumpy, int grumpySize, int X){
    int satisfied = 0;
    int maxPotential = 0;
    int currentPotential = 0;

    for (int i = 0; i < customersSize; i++) {
        if (grumpy[i] == 0) {
            satisfied += customers[i];
        }
    }

    for (int i = 0; i < X; i++) {
        if (grumpy[i] == 1) {
            currentPotential += customers[i];
        }
    }

    maxPotential = currentPotential;

    for (int i = X; i < customersSize; i++) {
        if (grumpy[i] == 1) {
            currentPotential += customers[i];
        }
        if (grumpy[i - X] == 1) {
            currentPotential -= customers[i - X];
        }
        if (currentPotential > maxPotential) {
            maxPotential = currentPotential;
        }
    }

    return satisfied + maxPotential;
}