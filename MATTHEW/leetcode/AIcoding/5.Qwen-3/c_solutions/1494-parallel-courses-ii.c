#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* neighbors;
    int size;
} Graph;

int** dp;
int n;
int m;

void dfs(int mask, int* degree, int* result) {
    if (mask == (1 << n) - 1) {
        *result = 0;
        return;
    }
    if (dp[mask] != -1) {
        *result = dp[mask];
        return;
    }
    int min_courses = INT_MAX;
    int current_degree = 0;
    for (int i = 0; i < n; i++) {
        if ((mask & (1 << i)) == 0 && degree[i] == 0) {
            current_degree++;
        }
    }
    for (int i = 0; i < n; i++) {
        if ((mask & (1 << i)) == 0 && degree[i] == 0) {
            int new_mask = mask | (1 << i);
            int new_degree[n];
            for (int j = 0; j < n; j++) {
                new_degree[j] = degree[j];
            }
            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) == 0 && (new_degree[j] > 0)) {
                    if ((mask & (1 << j)) == 0 && (mask & (1 << i)) == 0) {
                        new_degree[j]--;
                    }
                }
            }
            int temp_result;
            dfs(new_mask, new_degree, &temp_result);
            min_courses = (min_courses < temp_result + 1) ? min_courses : temp_result + 1;
        }
    }
    dp[mask] = min_courses;
    *result = min_courses;
}

int minNumberOfSemesters(int n, int* dependencies, int dependenciesSize) {
    Graph graph[n];
    for (int i = 0; i < n; i++) {
        graph[i].neighbors = (int*)malloc(n * sizeof(int));
        graph[i].size = 0;
    }
    for (int i = 0; i < dependenciesSize / 2; i++) {
        int u = dependencies[2 * i];
        int v = dependencies[2 * i + 1];
        graph[u].neighbors[graph[u].size++] = v;
    }
    int degree[n];
    for (int i = 0; i < n; i++) {
        degree[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < graph[i].size; j++) {
            degree[graph[i].neighbors[j]]++;
        }
    }
    int max_mask = 1 << n;
    dp = (int**)malloc(max_mask * sizeof(int*));
    for (int i = 0; i < max_mask; i++) {
        dp[i] = (int*)malloc(sizeof(int));
        *dp[i] = -1;
    }
    int result;
    dfs(0, degree, &result);
    return result;
}