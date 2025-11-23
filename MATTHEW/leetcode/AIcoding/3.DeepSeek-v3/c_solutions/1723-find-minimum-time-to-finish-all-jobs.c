int ans;

void backtrack(int* jobs, int jobsSize, int idx, int* workloads, int k, int max) {
    if (idx == jobsSize) {
        if (max < ans) ans = max;
        return;
    }
    if (max >= ans) return;

    for (int i = 0; i < k; i++) {
        if (workloads[i] + jobs[idx] < ans) {
            workloads[i] += jobs[idx];
            int old_max = max;
            if (workloads[i] > max) max = workloads[i];
            backtrack(jobs, jobsSize, idx + 1, workloads, k, max);
            max = old_max;
            workloads[i] -= jobs[idx];
        }
        if (workloads[i] == 0) break;
    }
}

int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int minimumTimeRequired(int* jobs, int jobsSize, int k) {
    ans = INT_MAX;
    int* workloads = (int*)calloc(k, sizeof(int));
    qsort(jobs, jobsSize, sizeof(int), cmp);
    backtrack(jobs, jobsSize, 0, workloads, k, 0);
    free(workloads);
    return ans;
}