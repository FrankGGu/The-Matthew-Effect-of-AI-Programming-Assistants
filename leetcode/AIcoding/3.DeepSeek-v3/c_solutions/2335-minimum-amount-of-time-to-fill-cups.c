int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int fillCups(int* amount, int amountSize) {
    int time = 0;
    while (1) {
        qsort(amount, amountSize, sizeof(int), cmp);
        if (amount[0] <= 0) break;
        amount[0]--;
        if (amount[1] > 0) amount[1]--;
        time++;
    }
    return time;
}