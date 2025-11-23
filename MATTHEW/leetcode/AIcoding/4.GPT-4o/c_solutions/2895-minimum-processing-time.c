int minimumProcessingTime(int* tasks, int tasksSize) {
    qsort(tasks, tasksSize, sizeof(int), cmp);
    int total_time = 0;
    for (int i = 0; i < tasksSize; i++) {
        total_time += tasks[i] * (tasksSize - i);
    }
    return total_time;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}