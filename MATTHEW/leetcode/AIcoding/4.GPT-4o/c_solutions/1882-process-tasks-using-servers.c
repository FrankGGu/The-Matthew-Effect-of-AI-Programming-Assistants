#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    int weight;
} Server;

typedef struct {
    int id;
    int time;
} Task;

int* assignTasks(int* servers, int serversSize, int* tasks, int tasksSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * tasksSize);
    *returnSize = tasksSize;
    int* serverAvailableTime = (int*)calloc(serversSize, sizeof(int));
    Server* serverList = (Server*)malloc(sizeof(Server) * serversSize);

    for (int i = 0; i < serversSize; i++) {
        serverList[i].id = i;
        serverList[i].weight = servers[i];
    }

    for (int i = 0; i < tasksSize; i++) {
        int minTime = INT_MAX;
        int serverId = -1;

        for (int j = 0; j < serversSize; j++) {
            if (serverAvailableTime[j] < minTime) {
                minTime = serverAvailableTime[j];
                serverId = j;
            } else if (serverAvailableTime[j] == minTime && serverList[j].weight < serverList[serverId].weight) {
                serverId = j;
            }
        }

        result[i] = serverId;
        serverAvailableTime[serverId] = (minTime > i ? minTime : i) + tasks[i];
    }

    free(serverAvailableTime);
    free(serverList);

    return result;
}