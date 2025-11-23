int cmp(const void* a, const void* b) {
    int* ta = *(int**)a;
    int* tb = *(int**)b;
    if (ta[1] == tb[1]) {
        return ta[0] - tb[0];
    }
    return ta[1] - tb[1];
}

int findMinimumTime(int** tasks, int tasksSize, int* tasksColSize) {
    qsort(tasks, tasksSize, sizeof(int*), cmp);

    int time[2001] = {0};
    int res = 0;

    for (int i = 0; i < tasksSize; i++) {
        int start = tasks[i][0];
        int end = tasks[i][1];
        int duration = tasks[i][2];

        int already = 0;
        for (int t = start; t <= end; t++) {
            if (time[t]) already++;
        }

        int need = duration - already;
        if (need > 0) {
            for (int t = end; t >= start && need > 0; t--) {
                if (!time[t]) {
                    time[t] = 1;
                    res++;
                    need--;
                }
            }
        }
    }

    return res;
}