#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int n, k;
int *jobs;
int best;

int check(long long max_load) {
    int *worker_load = (int *)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) {
        worker_load[i] = 0;
    }

    int assigned_workers = 0;
    int assigned_jobs = 0;

    while (assigned_jobs < n) {
        int worker_index = 0;
        while (worker_index < k && worker_load[worker_index] != 0) {
            worker_index++;
        }

        if (worker_index == k) {
            free(worker_load);
            return 0;
        }

        worker_load[worker_index] = jobs[assigned_jobs];
        assigned_jobs++;

        while (assigned_jobs < n) {
            int can_assign = 0;
            if (worker_load[worker_index] + jobs[assigned_jobs] <= max_load) {
                can_assign = 1;
            }

            if (can_assign) {
                worker_load[worker_index] += jobs[assigned_jobs];
                assigned_jobs++;
            } else {
                break;
            }
        }
    }

    free(worker_load);
    return 1;
}

void solve(int index, int *worker_load, int max_val) {
    if (index == n) {
        if (max_val < best) {
            best = max_val;
        }
        return;
    }

    for (int i = 0; i < k; i++) {
        worker_load[i] += jobs[index];
        int new_max = 0;
        for (int j = 0; j < k; j++) {
            if (worker_load[j] > new_max) {
                new_max = worker_load[j];
            }
        }

        if (new_max < best) {
            solve(index + 1, worker_load, new_max);
        }
        worker_load[i] -= jobs[index];
    }
}

int minimumTimeRequired(int* _jobs, int jobsSize, int _k) {
    jobs = _jobs;
    n = jobsSize;
    k = _k;

    long long left = 0;
    long long right = 0;
    for (int i = 0; i < n; i++) {
        right += jobs[i];
    }

    long long ans = right;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        if (check(mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}