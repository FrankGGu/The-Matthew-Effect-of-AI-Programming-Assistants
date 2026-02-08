#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int speed;
    int efficiency;
} Engineer;

int compare(const void *a, const void *b) {
    return ((Engineer*)b)->efficiency - ((Engineer*)a)->efficiency;
}

int compare_speed(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int maxPerformance(int n, int* speed, int speedSize, int* efficiency, int efficiencySize, int k){
    Engineer engineers[n];
    for (int i = 0; i < n; i++) {
        engineers[i].speed = speed[i];
        engineers[i].efficiency = efficiency[i];
    }

    qsort(engineers, n, sizeof(Engineer), compare);

    long long speed_sum = 0;
    int speeds[k];
    int speeds_size = 0;

    long long max_performance = 0;
    for (int i = 0; i < n; i++) {
        if (speeds_size < k) {
            speeds[speeds_size++] = engineers[i].speed;
            speed_sum += engineers[i].speed;
            qsort(speeds, speeds_size, sizeof(int), compare_speed);
        } else {
            if (engineers[i].speed > speeds[0]) {
                speed_sum -= speeds[0];
                speed_sum += engineers[i].speed;
                speeds[0] = engineers[i].speed;
                qsort(speeds, speeds_size, sizeof(int), compare_speed);
            }
        }

        long long current_performance = speed_sum * engineers[i].efficiency;
        if (current_performance > max_performance) {
            max_performance = current_performance;
        }
    }

    return max_performance % 1000000007;
}