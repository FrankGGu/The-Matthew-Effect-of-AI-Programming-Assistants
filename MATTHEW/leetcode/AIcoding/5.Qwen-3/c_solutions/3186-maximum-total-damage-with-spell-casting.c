#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumTotalDamage(int* power, int powerSize) {
    qsort(power, powerSize, sizeof(int), compare);

    int maxPower = 0;
    for (int i = 0; i < powerSize; i++) {
        if (power[i] > maxPower) {
            maxPower = power[i];
        }
    }

    int* damage = (int*)calloc(maxPower + 1, sizeof(int));
    for (int i = 0; i < powerSize; i++) {
        damage[power[i]] += power[i];
    }

    int prev = 0;
    int curr = 0;
    for (int i = 1; i <= maxPower; i++) {
        int temp = curr;
        if (damage[i] > 0) {
            curr = (prev + damage[i]) > curr ? (prev + damage[i]) : curr;
        }
        prev = temp;
    }

    free(damage);
    return curr;
}