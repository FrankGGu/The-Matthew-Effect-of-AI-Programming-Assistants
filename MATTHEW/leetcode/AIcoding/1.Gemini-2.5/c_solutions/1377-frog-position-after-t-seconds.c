#include <stdbool.h>

int adj[101][101];

double dfs(int u, int parent, int current_time, double current_prob, int t, int target) {
    if (current_time > t) {
        return 0.0;
    }

    int num_unvisited_children = 0;
    for (int i = 1; i <= adj[u][0]; ++i) {
        int v = adj[u][i];
        if (v != parent) {
            num_unvisited_children++;
        }
    }

    if (u == target) {
        if (current_time == t) {
            return current_prob;
        }
        if (current_time < t) {
            if (num_unvisited_children == 0) {
                return current_prob;
            } else {
                return 0.0;
            }
        }
    }

    if (current_time == t) {
        return 0.0;
    }

    if (num_unvisited_children == 0) {
        return 0.0;
    }

    double total_prob_from_children = 0.0;
    double prob_to_each_child = current_prob / num_unvisited_children;

    for (int i = 1; i <= adj[u][0]; ++i) {
        int v = adj[u][i];
        if (v != parent) {
            total_prob_from_children += dfs(v, u, current_time + 1, prob_to_each_child, t, target);
        }
    }

    return total_prob_from_children;
}

double frogPosition(int n, int** edges, int edgesSize, int* edgesColSize, int t, int target) {
    for (int i = 1; i <= n; ++i) {
        adj[i][0] = 0;
    }

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][++adj[u][0]] = v;
        adj[v][++adj[v][0]] = u;
    }

    return dfs(1, 0, 0, 1.0, t, target);
}