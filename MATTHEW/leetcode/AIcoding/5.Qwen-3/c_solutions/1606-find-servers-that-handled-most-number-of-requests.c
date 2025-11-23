#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int count;
} Server;

int compare(const void *a, const void *b) {
    Server *sa = (Server *)a;
    Server *sb = (Server *)b;
    if (sa->count != sb->count) {
        return sb->count - sa->count;
    }
    return sa->id - sb->id;
}

int* busiestServers(int k, int* arrival, int arrivalSize, int* load, int loadSize, int* returnSize) {
    int *result = NULL;
    *returnSize = 0;

    Server *servers = (Server *)calloc(k, sizeof(Server));
    for (int i = 0; i < k; ++i) {
        servers[i].id = i;
        servers[i].count = 0;
    }

    int *available = (int *)malloc(k * sizeof(int));
    for (int i = 0; i < k; ++i) {
        available[i] = i;
    }

    int availableSize = k;

    for (int i = 0; i < arrivalSize; ++i) {
        int time = arrival[i];
        int reqLoad = load[i];

        int j = 0;
        while (j < availableSize) {
            if (available[j] == -1) {
                j++;
                continue;
            }
            int serverId = available[j];
            if (time >= 0) {
                servers[serverId].count++;
                available[j] = -1;
                break;
            }
            j++;
        }

        int newAvailableSize = 0;
        for (int m = 0; m < availableSize; ++m) {
            if (available[m] != -1) {
                available[newAvailableSize++] = available[m];
            }
        }
        availableSize = newAvailableSize;
    }

    qsort(servers, k, sizeof(Server), compare);

    int maxCount = servers[0].count;
    int count = 0;
    for (int i = 0; i < k; ++i) {
        if (servers[i].count == maxCount) {
            count++;
        } else {
            break;
        }
    }

    result = (int *)malloc(count * sizeof(int));
    *returnSize = count;
    for (int i = 0; i < count; ++i) {
        result[i] = servers[i].id;
    }

    free(available);
    free(servers);
    return result;
}