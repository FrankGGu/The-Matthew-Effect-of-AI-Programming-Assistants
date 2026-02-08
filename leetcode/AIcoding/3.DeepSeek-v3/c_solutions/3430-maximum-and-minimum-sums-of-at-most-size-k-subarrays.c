#include <stdlib.h>

long long* maximumAndMinimum(int n, int* a, int k, int* returnSize) {
    long long* res = (long long*)malloc(2 * sizeof(long long));
    *returnSize = 2;
    res[0] = -1e18;
    res[1] = 1e18;

    int* dq_min = (int*)malloc(n * sizeof(int));
    int* dq_max = (int*)malloc(n * sizeof(int));
    int front_min = 0, rear_min = -1;
    int front_max = 0, rear_max = -1;
    long long sum = 0;

    for (int i = 0; i < n; i++) {
        while (front_min <= rear_min && a[dq_min[rear_min]] >= a[i]) rear_min--;
        dq_min[++rear_min] = i;

        while (front_max <= rear_max && a[dq_max[rear_max]] <= a[i]) rear_max--;
        dq_max[++rear_max] = i;

        sum += a[i];

        if (i >= k - 1) {
            while (dq_min[front_min] <= i - k) front_min++;
            while (dq_max[front_max] <= i - k) front_max++;

            long long min_val = a[dq_min[front_min]];
            long long max_val = a[dq_max[front_max]];
            long long sub_sum = sum;
            if (i >= k) sub_sum -= a[i - k];

            if (sub_sum * min_val > res[0]) res[0] = sub_sum * min_val;
            if (sub_sum * max_val < res[1]) res[1] = sub_sum * max_val;

            sum -= a[i - k + 1];
        }
    }

    free(dq_min);
    free(dq_max);
    return res;
}