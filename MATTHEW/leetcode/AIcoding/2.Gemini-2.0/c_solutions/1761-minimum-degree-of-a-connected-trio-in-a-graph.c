#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTrioDegree(int n, int** edges, int edgesSize, int* edgesColSize){
    int adj[n][n];
    int degree[n];
    for(int i=0; i<n; i++){
        degree[i] = 0;
        for(int j=0; j<n; j++){
            adj[i][j] = 0;
        }
    }

    for(int i=0; i<edgesSize; i++){
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        adj[u][v] = 1;
        adj[v][u] = 1;
        degree[u]++;
        degree[v]++;
    }

    int minDegree = INT_MAX;
    for(int i=0; i<n; i++){
        for(int j=i+1; j<n; j++){
            if(adj[i][j]){
                for(int k=j+1; k<n; k++){
                    if(adj[i][k] && adj[j][k]){
                        int trioDegree = degree[i] + degree[j] + degree[k] - 6;
                        if(trioDegree < minDegree){
                            minDegree = trioDegree;
                        }
                    }
                }
            }
        }
    }

    if(minDegree == INT_MAX){
        return -1;
    }
    return minDegree;
}