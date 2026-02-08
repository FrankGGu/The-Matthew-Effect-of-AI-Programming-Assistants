/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    long long x = *(long long*)a;
    long long y = *(long long*)b;
    if (x < y) return -1;
    if (x > y) return 1;
    return 0;
}

int* successfulPairs(int* spells, int spellsSize, int* potions, int potionsSize, long long success, int* returnSize) {
    *returnSize = spellsSize;
    int* res = (int*)malloc(spellsSize * sizeof(int));

    long long* sortedPotions = (long long*)malloc(potionsSize * sizeof(long long));
    for (int i = 0; i < potionsSize; i++) {
        sortedPotions[i] = potions[i];
    }
    qsort(sortedPotions, potionsSize, sizeof(long long), cmp);

    for (int i = 0; i < spellsSize; i++) {
        long long minPotion = (success + spells[i] - 1) / spells[i];

        int left = 0, right = potionsSize - 1;
        int idx = potionsSize;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sortedPotions[mid] >= minPotion) {
                idx = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        res[i] = potionsSize - idx;
    }

    free(sortedPotions);
    return res;
}