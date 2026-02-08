int cmp(const void* a, const void* b) {
    int* task1 = *(int**)a;
    int* task2 = *(int**)b;
    int diff1 = task1[1] - task1[0];
    int diff2 = task2[1] - task2[0];
    if (diff1 != diff2) {
        return diff1 - diff2;
    }
    return task1[1] - task2[1];
}

int minimumEffort(int** tasks, int tasksSize, int* tasksColSize) {
    qsort(tasks, tasksSize, sizeof(int*), cmp);
    int res = 0;
    int curr = 0;
    for (int i = tasksSize - 1; i >= 0; i--) {
        if (curr < tasks[i][1]) {
            res += tasks[i][1] - curr;
            curr = tasks[i][1];
        }
        curr -= tasks[i][0];
    }
    return res;
}