#include <stdlib.h> // For malloc, qsort, abs

int find_set(int* parent_arr, int i) {
    if (parent_arr[i] == i)
        return i;
    return parent_arr[i] = find_set(parent_arr, parent_arr[i]);
}

void unite_sets(int* parent_arr, int* rank_arr, int i, int j) {
    int root_i = find_set(parent_arr, i);
    int root_j = find_set(parent_arr, j);

    if (root_i != root_j) {
        if (rank_arr[root_i] < rank_arr[root_j]) {
            parent_arr[root_i] = root_j;
        } else if (rank_arr[root_i] > rank_arr[root_j]) {
            parent_arr[root_j] = root_i;
        } else {
            parent_arr[root_j] = root_i;
            rank_arr[root_i]++;
        }
    }
}

typedef struct {
    int u, v, weight;
} Edge;

int compareEdges(const void* a, const void* b) {
    return ((Edge*)a)->weight - ((Edge*)b)->weight;
}

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize) {
    int num_points = pointsSize;
    if (num_points <= 1) {
        return 0;
    }

    int num_edges = num_points * (num_points - 1) / 2;
    Edge* edges = (Edge*)malloc(num_edges * sizeof(Edge));

    int edge_idx = 0;
    for (int i = 0; i < num_points; i++) {
        for (int j = i + 1; j < num_points; j++) {
            edges[edge_idx].u = i;
            edges[edge_idx].v = j;
            edges[edge_idx].weight = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
            edge_idx++;
        }
    }

    qsort(edges, num_edges, sizeof(Edge), compareEdges);

    int* parent = (int*)malloc(num_points * sizeof(int));
    int* rank = (int*)malloc(num_points * sizeof(int));

    for (int i = 0; i < num_points; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    long long mst_cost = 0;
    int edges_count = 0;

    for (int i = 0; i < num_edges; i++) {
        int u = edges[i].u;
        int v = edges[i].v;
        int weight = edges[i].weight;

        if (find_set(parent, u) != find_set(parent, v)) {
            unite_sets(parent, rank, u, v);
            mst_cost += weight;
            edges_count++;
            if (edges_count == num_points - 1) {
                break;
            }
        }
    }

    free(edges);
    free(parent);
    free(rank);

    return (int)mst_cost;
}