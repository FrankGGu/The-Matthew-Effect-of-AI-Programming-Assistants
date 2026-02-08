#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* successfulPairs(int* spells, int spellsSize, int* potions, int potionsSize, long long success, int* returnSize) {
    qsort(potions, potionsSize, sizeof(int), compare);
    int* result = (int*)malloc(spellsSize * sizeof(int));
    *returnSize = spellsSize;

    for (int i = 0; i < spellsSize; i++) {
        int left = 0;
        int right = potionsSize - 1;
        int count = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long product = (long long)spells[i] * (long long)potions[mid];

            if (product >= success) {
                count = potionsSize - mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result[i] = count;
    }

    return result;
}