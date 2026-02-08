int* successfulPairs(int* spells, int spellsSize, int* potions, int potionsSize, long long success, int* returnSize) {
    int* result = (int*)malloc(spellsSize * sizeof(int));
    *returnSize = spellsSize;
    qsort(potions, potionsSize, sizeof(int), cmp);

    for (int i = 0; i < spellsSize; i++) {
        long long required = (success + potionsSize - 1) / spells[i];
        int count = potionsSize - (int)(bsearch(&required, potions, potionsSize, sizeof(int), cmp) - potions);
        result[i] = count;
    }

    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}