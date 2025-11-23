#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int amountOfTime(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize, int start) {
    int n = numsSize;
    int max_time = 0;

    int* adj[n];
    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    int* adj_size = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        adj_size[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        adj_size[u]++;
        adj_size[v]++;
    }

    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(adj_size[i] * sizeof(int));
        adj_size[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        adj[u][adj_size[u]++] = v;
        adj[v][adj_size[v]++] = u;
    }

    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }

    dist[start] = 0;

    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0;
    int tail = 0;
    queue[tail++] = start;

    while (head < tail) {
        int u = queue[head++];

        for (int i = 0; i < adj_size[u]; i++) {
            int v = adj[u][i];
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        int time = dist[i] == -1 ? 0 : dist[i] + nums[i];

        if (i == start) {
            time = nums[i];
        } else {
            time = dist[i] + nums[i];
        }

        if (dist[i] != -1) {
            max_time = (max_time > time - dist[i]) ? max_time : time - dist[i];
        }
    }

    int max_depth = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] > max_depth) {
            max_depth = dist[i];
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        if(i == start){
            result = (result > nums[i]) ? result : nums[i];
        }
        else{
            result = (result > dist[i] + nums[i]) ? result : dist[i] + nums[i];
        }
    }

    int max_val = 0;
    for(int i = 0; i < n; i++){
        max_val = (max_val > nums[i]) ? max_val : nums[i];
    }

    free(queue);
    free(dist);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj_size);

    int max_time_taken = 0;
    for(int i = 0; i < n; i++){
        if(dist[i] != -1){
            max_time_taken = (max_time_taken > dist[i]) ? max_time_taken : dist[i];
        }
    }

    int max_needed_time = 0;
    for(int i = 0; i < n; i++){
        if(dist[i] != -1){
          max_needed_time = (max_needed_time > nums[i]) ? max_needed_time : nums[i];
        }
    }

    int max_path_time = 0;
    for(int i = 0; i < n; i++){
        if(i != start){
             max_path_time = (max_path_time > dist[i] + nums[i]) ? max_path_time : dist[i] + nums[i];
        }
        else{
            max_path_time = (max_path_time > nums[i]) ? max_path_time : nums[i];
        }

    }

    int max_time_req = 0;
    for(int i = 0; i < n; i++){
        max_time_req = (max_time_req > nums[i]) ? max_time_req : nums[i];
    }

    return max_time_taken;
}