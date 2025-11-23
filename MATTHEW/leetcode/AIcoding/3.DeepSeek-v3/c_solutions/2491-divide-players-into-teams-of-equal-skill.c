int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

long long dividePlayers(int* skill, int skillSize) {
    qsort(skill, skillSize, sizeof(int), cmp);

    long long totalChemistry = 0;
    int targetSum = skill[0] + skill[skillSize - 1];

    for (int i = 0; i < skillSize / 2; i++) {
        int currentSum = skill[i] + skill[skillSize - 1 - i];
        if (currentSum != targetSum) {
            return -1;
        }
        totalChemistry += (long long)skill[i] * skill[skillSize - 1 - i];
    }

    return totalChemistry;
}