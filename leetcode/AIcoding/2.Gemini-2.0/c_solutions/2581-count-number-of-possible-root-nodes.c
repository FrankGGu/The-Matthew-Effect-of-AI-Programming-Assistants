#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Edge {
    int u, v;
};

int rootCount(int** edges, int edgesSize, int* edgesColSize, int guesses[][2], int guessesSize, int k){
    int n = 0;
    for(int i = 0; i < edgesSize; i++){
        n = (edges[i][0] > n) ? edges[i][0] : n;
        n = (edges[i][1] > n) ? edges[i][1] : n;
    }
    n++;

    int adj[n];
    for(int i = 0; i < n; i++) adj[i] = 0;

    int* adj_list[n];
    for(int i = 0; i < n; i++){
        adj_list[i] = (int*)malloc(sizeof(int) * edgesSize * 2);
        adj[i] = 0;
    }

    for(int i = 0; i < edgesSize; i++){
        int u = edges[i][0], v = edges[i][1];
        adj_list[u][adj[u]++] = v;
        adj_list[v][adj[v]++] = u;
    }

    int correct_guesses = 0;
    for(int i = 0; i < guessesSize; i++){
        int u = guesses[i][0], v = guesses[i][1];

    }

    int* parent = (int*)malloc(sizeof(int) * n);
    int* correct = (int*)malloc(sizeof(int) * n);
    for(int i = 0; i < n; i++) parent[i] = -1;
    for(int i = 0; i < n; i++) correct[i] = 0;

    void dfs(int u, int p){
        parent[u] = p;
        for(int i = 0; i < adj[u]; i++){
            int v = adj_list[u][i];
            if(v != p){
                dfs(v, u);
            }
        }
    }

    dfs(0, -1);

    for(int i = 0; i < guessesSize; i++){
        int u = guesses[i][0], v = guesses[i][1];
        if(parent[v] == u) correct[0]++;
    }

    int ans = 0;
    int* q = (int*)malloc(sizeof(int) * n);
    int q_front = 0, q_rear = 0;
    q[q_rear++] = 0;
    int* visited = (int*)malloc(sizeof(int) * n);
    for(int i = 0; i < n; i++) visited[i] = 0;
    visited[0] = 1;

    while(q_front < q_rear){
        int u = q[q_front++];

        if(correct[u] >= k) ans++;

        for(int i = 0; i < adj[u]; i++){
            int v = adj_list[u][i];
            if(!visited[v]){
                visited[v] = 1;
                correct[v] = correct[u];
                int found = 0;
                for(int j = 0; j < guessesSize; j++){
                    if(guesses[j][0] == u && guesses[j][1] == v){
                        correct[v]--;
                        found = 1;
                        break;
                    }
                }
                if(!found){
                    for(int j = 0; j < guessesSize; j++){
                        if(guesses[j][0] == v && guesses[j][1] == u){
                            correct[v]++;
                            break;
                        }
                    }
                }

                q[q_rear++] = v;
            }
        }
    }

    for(int i = 0; i < n; i++) free(adj_list[i]);
    free(parent);
    free(correct);
    free(q);
    free(visited);

    return ans;
}