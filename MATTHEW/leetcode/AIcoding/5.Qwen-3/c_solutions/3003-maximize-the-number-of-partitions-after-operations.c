#include <stdio.h>
#include <stdlib.h>

int maxPartitions(int* arr, int n) {
    int count = 0;
    int end = 0;
    int max_reach = 0;
    for (int i = 0; i < n; i++) {
        max_reach = (max_reach > i + arr[i]) ? max_reach : i + arr[i];
        if (i == end) {
            count++;
            end = max_reach;
        }
    }
    return count;
}