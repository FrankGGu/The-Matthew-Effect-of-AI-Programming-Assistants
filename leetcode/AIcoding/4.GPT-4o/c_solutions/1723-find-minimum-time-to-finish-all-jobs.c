int canFinish(int* jobs, int jobsSize, int* workers, int workersSize, int time) {
    int* finishTime = (int*)calloc(workersSize, sizeof(int));
    int i, j;

    for (i = 0; i < jobsSize; i++) {
        int jobAssigned = 0;
        for (j = 0; j < workersSize; j++) {
            if (finishTime[j] + jobs[i] <= time) {
                finishTime[j] += jobs[i];
                jobAssigned = 1;
                break;
            }
        }
        if (!jobAssigned) {
            free(finishTime);
            return 0;
        }
    }
    free(finishTime);
    return 1;
}

int minimumTimeRequired(int* jobs, int jobsSize, int* workers, int workersSize) {
    int left = 0, right = 0;
    for (int i = 0; i < jobsSize; i++) {
        right += jobs[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (canFinish(jobs, jobsSize, workers, workersSize, mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}