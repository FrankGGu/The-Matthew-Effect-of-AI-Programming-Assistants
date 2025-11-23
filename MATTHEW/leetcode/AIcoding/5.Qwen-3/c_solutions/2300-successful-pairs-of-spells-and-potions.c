#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* successfulPairs(int* spells, int spellsSize, int* potions, int potionsSize, long long success, int* returnSize) {
    qsort(potions, potionsSize, sizeof(int), compare);
    int* result = (int*)malloc(spellsSize * sizeof(int));
    for (int i = 0; i < spellsSize; i++) {
        long long target = (success + spells[i] - 1) / spells[i];
        int left = 0, right = potionsSize - 1;
        int count = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (potions[mid] >= target) {
                count = potionsSize - mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result[i] = count;
    }
    *returnSize = spellsSize;
    return result;
}