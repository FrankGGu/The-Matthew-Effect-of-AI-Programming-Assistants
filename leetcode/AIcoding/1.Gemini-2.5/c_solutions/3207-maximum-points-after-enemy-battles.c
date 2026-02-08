#include <stdlib.h>

int compare(const void* a, const void* b) {
    long long val_a = *(long long*)a;
    long long val_b = *(long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

long long maximumPoints(long long* enemies, int enemiesSize, long long initialEnergy) {
    qsort(enemies, enemiesSize, sizeof(long long), compare);

    long long currentEnergy = initialEnergy;
    long long currentPoints = 0;

    int left = 0;
    int right = enemiesSize - 1;

    while (left <= right) {
        if (currentEnergy >= enemies[left]) {
            currentEnergy -= enemies[left];
            currentPoints += 1;
            left++;
        } else if (currentPoints >= 1 && left < right) {
            currentEnergy += enemies[right];
            currentPoints -= 1;
            right--;
        } else {
            break;
        }
    }

    return currentPoints;
}