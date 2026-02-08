#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int index;
    int weight;
    int finish_time;
} Server;

int compare_servers(const void *a, const void *b) {
    const Server *serverA = (const Server *)a;
    const Server *serverB = (const Server *)b;

    if (serverA->finish_time != serverB->finish_time) {
        return serverA->finish_time - serverB->finish_time;
    } else if (serverA->weight != serverB->weight) {
        return serverA->weight - serverB->weight;
    } else {
        return serverA->index - serverB->index;
    }
}

int* assignTasks(int* servers, int serversSize, int* tasks, int tasksSize, int* returnSize){
    int* result = (int*)malloc(tasksSize * sizeof(int));
    *returnSize = tasksSize;

    Server* server_list = (Server*)malloc(serversSize * sizeof(Server));
    for (int i = 0; i < serversSize; i++) {
        server_list[i].index = i;
        server_list[i].weight = servers[i];
        server_list[i].finish_time = 0;
    }

    for (int i = 0; i < tasksSize; i++) {
        qsort(server_list, serversSize, sizeof(Server), compare_servers);

        int j = 0;
        while (server_list[j].finish_time > i) {
            j++;
            if (j == serversSize) {
                j = 0;
                qsort(server_list, serversSize, sizeof(Server), compare_servers);
                while (server_list[j].finish_time > i) {
                   j++;
                   if(j == serversSize){
                       j = 0;
                       qsort(server_list, serversSize, sizeof(Server), compare_servers);
                   }
                }

            }
           qsort(server_list, serversSize, sizeof(Server), compare_servers);
        }
        result[i] = server_list[j].index;
        server_list[j].finish_time = (server_list[j].finish_time > i ? server_list[j].finish_time : i) + tasks[i];
    }

    free(server_list);
    return result;
}