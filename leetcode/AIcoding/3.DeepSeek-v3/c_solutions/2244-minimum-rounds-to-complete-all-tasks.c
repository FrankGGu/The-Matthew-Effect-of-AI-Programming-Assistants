int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minimumRounds(int* tasks, int tasksSize) {
    qsort(tasks, tasksSize, sizeof(int), cmp);

    int rounds = 0;
    int count = 1;

    for (int i = 1; i <= tasksSize; i++) {
        if (i < tasksSize && tasks[i] == tasks[i - 1]) {
            count++;
        } else {
            if (count == 1) {
                return -1;
            }
            rounds += (count + 2) / 3;
            count = 1;
        }
    }

    return rounds;
}