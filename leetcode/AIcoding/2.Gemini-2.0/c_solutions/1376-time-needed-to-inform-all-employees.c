#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numOfMinutes(int n, int headID, int* manager, int managerSize, int* informTime, int informTimeSize) {
    int* adj[n];
    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < managerSize; i++) {
        if (manager[i] != -1) {
            int* node = (int*)malloc(sizeof(int));
            *node = i;
            node[1] = (int)adj[manager[i]];
            adj[manager[i]] = node;
        }
    }

    int max_time = 0;
    int stack[n];
    int top;

    int dfs(int u, int current_time) {
        current_time += informTime[u];
        int max_child_time = current_time;

        int* v = adj[u];
        while (v != NULL) {
            int child = *v;
            int child_time = dfs(child, current_time);
            if(child_time > max_child_time){
                max_child_time = child_time;
            }
            v = (int*)v[1];
        }

        return max_child_time;
    }

    return dfs(headID, 0) - informTime[headID];
}