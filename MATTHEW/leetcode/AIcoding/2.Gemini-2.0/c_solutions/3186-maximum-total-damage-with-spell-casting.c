#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

long long maxTotalDamage(int* damage, int damageSize, int* cost, int costSize, int armor) {
    qsort(damage, damageSize, sizeof(int), compare);

    long long sum = 0;
    int maxDamage = 0;
    for (int i = 0; i < damageSize; i++) {
        sum += damage[i];
        if (damage[i] > maxDamage) {
            maxDamage = damage[i];
        }
    }

    long long protectedDamage = (long long)maxDamage > armor ? armor : (long long)maxDamage;
    return sum - protectedDamage;
}