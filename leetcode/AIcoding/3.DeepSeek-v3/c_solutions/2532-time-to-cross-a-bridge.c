typedef struct {
    int time;
    int index;
} Worker;

int compare(const void* a, const void* b) {
    Worker* w1 = (Worker*)a;
    Worker* w2 = (Worker*)b;
    if (w1->time != w2->time) {
        return w1->time - w2->time;
    }
    return w1->index - w2->index;
}

int findCrossingTime(int n, int k, int** time, int timeSize, int* timeColSize) {
    Worker* workers = (Worker*)malloc(k * sizeof(Worker));
    for (int i = 0; i < k; i++) {
        workers[i].time = time[i][0] + time[i][2];
        workers[i].index = i;
    }

    qsort(workers, k, sizeof(Worker), compare);

    int leftSize = k;
    int* left = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        left[i] = workers[k - 1 - i].index;
    }

    int* right = (int*)malloc(k * sizeof(int));
    int rightSize = 0;

    int* workLeft = (int*)malloc(k * sizeof(int));
    int workLeftSize = 0;
    int* workRight = (int*)malloc(k * sizeof(int));
    int workRightSize = 0;

    int curTime = 0;
    int boxes = n;

    while (boxes > 0 || workRightSize > 0 || rightSize > 0) {
        while (workLeftSize > 0 && workLeft[0] <= curTime) {
            int worker = workLeft[0];
            for (int i = 1; i < workLeftSize; i++) {
                workLeft[i - 1] = workLeft[i];
            }
            workLeftSize--;

            for (int i = leftSize; i > 0; i--) {
                left[i] = left[i - 1];
            }
            left[0] = worker;
            leftSize++;
        }

        while (workRightSize > 0 && workRight[0] <= curTime) {
            int worker = workRight[0];
            for (int i = 1; i < workRightSize; i++) {
                workRight[i - 1] = workRight[i];
            }
            workRightSize--;

            for (int i = leftSize; i > 0; i--) {
                left[i] = left[i - 1];
            }
            left[0] = worker;
            leftSize++;
        }

        if (rightSize > 0) {
            int worker = right[0];
            for (int i = 1; i < rightSize; i++) {
                right[i - 1] = right[i];
            }
            rightSize--;

            curTime += time[worker][2];

            for (int i = workLeftSize; i > 0; i--) {
                workLeft[i] = workLeft[i - 1];
            }
            workLeft[0] = curTime + time[worker][3];
            workLeftSize++;

            boxes--;
        } else if (leftSize > 0 && boxes > 0) {
            int worker = left[0];
            for (int i = 1; i < leftSize; i++) {
                left[i - 1] = left[i];
            }
            leftSize--;

            curTime += time[worker][0];

            for (int i = workRightSize; i > 0; i--) {
                workRight[i] = workRight[i - 1];
            }
            workRight[0] = curTime + time[worker][1];
            workRightSize++;
        } else {
            int nextTime = INT_MAX;
            if (workLeftSize > 0 && workLeft[0] < nextTime) {
                nextTime = workLeft[0];
            }
            if (workRightSize > 0 && workRight[0] < nextTime) {
                nextTime = workRight[0];
            }
            if (nextTime != INT_MAX) {
                curTime = nextTime;
            }
        }
    }

    free(workers);
    free(left);
    free(right);
    free(workLeft);
    free(workRight);

    return curTime;
}