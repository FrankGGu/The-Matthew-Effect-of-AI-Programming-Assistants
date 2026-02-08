#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getCoprimes(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize, int* returnSize){
    int *ans = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        ans[i] = -1;
    }

    int adj[numsSize][numsSize];
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][v] = 1;
        adj[v][u] = 1;
    }

    int gcd(int a, int b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }

    void dfs(int node, int parent, int depth, int* path, int* path_depth, int* path_val) {
        int best_depth = -1;
        int best_node = -1;
        for (int i = 0; i < depth; i++) {
            if (gcd(nums[node], path_val[i]) == 1) {
                if (path_depth[i] > best_depth) {
                    best_depth = path_depth[i];
                    best_node = path[i];
                }
            }
        }
        ans[node] = best_node;

        int old_node = -1;
        int old_depth = -1;
        int old_val = -1;
        for(int i = 0; i < depth; i++){
            if(path[i] == node){
                old_node = path[i];
                old_depth = path_depth[i];
                old_val = path_val[i];
                path[i] = -1;
                path_depth[i] = -1;
                path_val[i] = -1;
                break;
            }
        }

        int current_index = depth;
        for(int i = 0; i < depth; i++){
            if(path[i] == -1){
                current_index = i;
                break;
            }
        }

        path[current_index] = node;
        path_depth[current_index] = depth;
        path_val[current_index] = nums[node];

        for (int neighbor = 0; neighbor < numsSize; neighbor++) {
            if (adj[node][neighbor] == 1 && neighbor != parent) {
                dfs(neighbor, node, depth + 1, path, path_depth, path_val);
            }
        }

        if(old_node != -1){
            path[current_index] = -1;
            path_depth[current_index] = -1;
            path_val[current_index] = -1;

            for(int i = 0; i < depth; i++){
                if(path[i] == -1){
                    path[i] = old_node;
                    path_depth[i] = old_depth;
                    path_val[i] = old_val;
                    break;
                }
            }
        } else {
            path[current_index] = -1;
            path_depth[current_index] = -1;
            path_val[current_index] = -1;
        }
    }

    int path[numsSize];
    int path_depth[numsSize];
    int path_val[numsSize];
    for (int i = 0; i < numsSize; i++) {
        path[i] = -1;
        path_depth[i] = -1;
        path_val[i] = -1;
    }

    dfs(0, -1, 0, path, path_depth, path_val);

    *returnSize = numsSize;
    return ans;
}