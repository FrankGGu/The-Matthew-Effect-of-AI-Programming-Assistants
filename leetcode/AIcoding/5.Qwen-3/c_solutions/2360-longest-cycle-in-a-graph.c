#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int longestCycle(int* graph, int graphSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = graphSize;
    int* visited = (int*)malloc(n * sizeof(int));
    int* in_degree = (int*)malloc(n * sizeof(int));
    int* parent = (int*)malloc(n * sizeof(int));
    int i;

    for (i = 0; i < n; i++) {
        visited[i] = 0;
        in_degree[i] = 0;
    }

    for (i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        in_degree[v]++;
    }

    for (i = 0; i < n; i++) {
        if (in_degree[i] == 0) {
            visited[i] = 1;
        }
    }

    for (i = 0; i < n; i++) {
        if (visited[i] == 0) {
            int current = i;
            while (visited[current] == 0) {
                visited[current] = 1;
                int next = graph[current];
                if (next == -1) break;
                parent[next] = current;
                current = next;
            }
        }
    }

    int max_cycle = 0;
    for (i = 0; i < n; i++) {
        if (visited[i] == 1) {
            int start = i;
            int count = 0;
            while (visited[start] == 1) {
                visited[start] = 2;
                start = graph[start];
                count++;
                if (start == -1) break;
            }
            if (start != -1 && visited[start] == 2) {
                max_cycle = (count > max_cycle) ? count : max_cycle;
            }
        }
    }

    free(visited);
    free(in_degree);
    free(parent);
    return max_cycle;
}