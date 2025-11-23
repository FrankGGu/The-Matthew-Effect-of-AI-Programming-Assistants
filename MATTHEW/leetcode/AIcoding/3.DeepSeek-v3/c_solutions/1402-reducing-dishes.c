int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maxSatisfaction(int* satisfaction, int satisfactionSize) {
    qsort(satisfaction, satisfactionSize, sizeof(int), cmp);

    int max = 0;
    int sum = 0;
    int total = 0;

    for (int i = satisfactionSize - 1; i >= 0; i--) {
        sum += satisfaction[i];
        total += sum;
        if (total > max) {
            max = total;
        }
    }

    return max;
}