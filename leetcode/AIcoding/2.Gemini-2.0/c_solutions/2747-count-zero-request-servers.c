#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countServers(int n, int** logs, int logsSize, int* logsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        int time = queries[i][0];
        int count = n;
        int* servers = (int*)calloc(n + 1, sizeof(int));
        for (int j = 0; j < logsSize; j++) {
            if (logs[j][1] <= time) {
                if (servers[logs[j][0]] == 0) {
                    servers[logs[j][0]] = 1;
                    count--;
                }
            }
        }
        ans[i] = count;
        free(servers);
    }
    return ans;
}