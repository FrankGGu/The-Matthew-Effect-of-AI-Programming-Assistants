int maxSatisfaction(int* satisfaction, int satisfactionSize) {
    qsort(satisfaction, satisfactionSize, sizeof(int), cmp);
    int maxSatisfaction = 0, currentSatisfaction = 0, totalSatisfaction = 0;

    for (int i = satisfactionSize - 1; i >= 0; i--) {
        totalSatisfaction += satisfaction[i];
        currentSatisfaction += totalSatisfaction;
        if (currentSatisfaction > maxSatisfaction) {
            maxSatisfaction = currentSatisfaction;
        }
    }

    return maxSatisfaction;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}