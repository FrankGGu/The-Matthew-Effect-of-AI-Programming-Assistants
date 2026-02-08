#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxPowerOfHero(int* heroes, int heroesSize) {
    qsort(heroes, heroesSize, sizeof(int), compare);
    int maxPower = 0;
    for (int i = 0; i < heroesSize; i++) {
        int power = 1;
        for (int j = i + 1; j < heroesSize; j++) {
            if (heroes[j] == heroes[i]) {
                power++;
            } else {
                break;
            }
        }
        if (power > maxPower) {
            maxPower = power;
        }
    }
    return maxPower;
}