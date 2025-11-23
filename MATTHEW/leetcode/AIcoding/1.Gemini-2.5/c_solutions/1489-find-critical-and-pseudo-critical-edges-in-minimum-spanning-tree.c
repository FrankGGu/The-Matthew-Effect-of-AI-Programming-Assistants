#include <stdlib.h>
#include <string.h>

typedef struct {
    int* parent;
    int* sz; // Using size for union by size optimization
    int count; // Number of disjoint sets
} DSU;

void dsu_init(DSU* dsu, int n) {
    dsu->parent = (int*)malloc(sizeof(int) * n);
    dsu->sz = (int*)malloc(sizeof(int) * n);
    dsu->count = n;
    for (int i = 0; i < n; ++i) {
        dsu->parent[i] = i;
        dsu->sz[i] = 1;
    }
}

int dsu_find(DSU* dsu, int i) {
    if (dsu->parent[i] == i) {
        return i;
    }
    return dsu->parent[i] = dsu_find(dsu, dsu->parent[i]);
}

int dsu_unite(DSU* dsu, int i, int j) {
    int root_i = dsu_find(dsu, i);
    int root_j = dsu_find(dsu, j);
    if (root_i != root_j) {
        if (dsu->sz[root_i] < dsu->sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        dsu->parent[root_j] = root_i;
        dsu->sz[root_i] += dsu->sz[root_j];
        dsu->count--;
        return 1; // Union successful
    }
    return 0; // Already in the same set
}

void dsu_free(DSU* dsu) {
    free(dsu->parent);
    free(dsu->sz);
}

typedef struct {
    int u, v, weight, original_index;
} Edge;

int compareEdges(const void* a, const void* b) {
    return ((Edge*)a)->weight - ((Edge*)b)->weight;
}

int* calculate_mst(int n, Edge* sorted_edges, int num_total_edges, int exclude_original_idx, int include_original_idx) {
    DSU dsu;
    dsu_init(&dsu, n);
    int current_mst_cost = 0;
    int edges_in_mst_count = 0;

    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = -1; // Default to failure
    result[1] = 0;

    // If an edge is forced to be included
    if (include_original_idx != -1) {
        // Find the edge with include_original_idx and process it first
        for (int i = 0; i < num_total_edges; ++i) {
            if (sorted_edges[i].original_index == include_original_idx) {
                if (dsu_unite(&dsu, sorted_edges[i].u, sorted_edges[i].v)) {
                    current_mst_cost += sorted_edges[i].weight;
                    edges_in_mst_count++;
                }
                break; // Found and processed the forced edge, move to general loop
            }
        }
    }

    // Iterate through all sorted edges
    for (int i = 0; i < num_total_edges; ++i) {
        // Skip excluded edge
        if (sorted_edges[i].original_index == exclude_original_idx) {
            continue;
        }
        // Skip already included forced edge (if it was forced)
        if (include_original_idx != -1 && sorted_edges[i].original_index == include_original_idx) {
            continue;
        }

        if (dsu_unite(&dsu, sorted_edges[i].u, sorted_edges[i].v)) {
            current_mst_cost += sorted_edges[i].weight;
            edges_in_mst_count++;
        }
    }

    dsu_free(&dsu);

    // Check if a spanning tree was formed
    if (edges_in_mst_count == n - 1) {
        result[0] = current_mst_cost;
    } else {
        result[0] = -1; // Indicate not a spanning tree
    }
    result[1] = edges_in_mst_count; // Number of edges actually in the MST (or forest)
    return result;
}

int** findCriticalAndPseudoCriticalEdges(int n, int** edges, int edgesSize, int* edgesColSize, int** returnColumnSizes, int* returnSize) {
    // 1. Prepare edges with original indices
    Edge* all_edges = (Edge*)malloc(sizeof(Edge) * edgesSize);
    for (int i = 0; i < edgesSize; ++i) {
        all_edges[i].u = edges[i][0];
        all_edges[i].v = edges[i][1];
        all_edges[i].weight = edges[i][2];
        all_edges[i].original_index = i; // Store original index
    }

    // 2. Sort edges by weight
    qsort(all_edges, edgesSize, sizeof(Edge), compareEdges);

    // 3. Calculate base MST cost
    int* base_mst_info = calculate_mst(n, all_edges, edgesSize, -1, -1);
    int base_mst_cost = base_mst_info[0];
    free(base_mst_info);

    // Prepare dynamic lists for critical and pseudo-critical edges
    int* critical_edges_list = (int*)malloc(sizeof(int) * edgesSize);
    int critical_count = 0;
    int* pseudo_critical_edges_list = (int*)malloc(sizeof(int) * edgesSize);
    int pseudo_critical_count = 0;

    // 4. Iterate through original edges to classify each one
    for (int i = 0; i < edgesSize; ++i) {
        // Check if edge 'i' is critical: calculate MST excluding edge 'i'
        int* exclude_info = calculate_mst(n, all_edges, edgesSize, i, -1);
        int exclude_cost = exclude_info[0];
        free(exclude_info);

        // If excluding edge 'i' results in a higher MST cost or no spanning tree, it's critical
        if (exclude_cost == -1 || exclude_cost > base_mst_cost) {
            critical_edges_list[critical_count++] = i;
        } else {
            // If not critical, check if it's pseudo-critical: calculate MST forcing edge 'i' to be included
            int* include_info = calculate_mst(n, all_edges, edgesSize, -1, i);
            int include_cost = include_info[0];
            free(include_info);

            // If forcing edge 'i' results in an MST with the same cost as base_mst_cost, it's pseudo-critical
            if (include_cost != -1 && include_cost == base_mst_cost) {
                pseudo_critical_edges_list[pseudo_critical_count++] = i;
            }
        }
    }

    // 5. Prepare the return value structure
    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(sizeof(int) * 2);
    (*returnColumnSizes)[0] = critical_count;
    (*returnColumnSizes)[1] = pseudo_critical_count;

    int** result = (int**)malloc(sizeof(int*) * 2);
    result[0] = (int*)malloc(sizeof(int) * critical_count);
    for (int i = 0; i < critical_count; ++i) {
        result[0][i] = critical_edges_list[i];
    }
    result[1] = (int*)malloc(sizeof(int) * pseudo_critical_count);
    for (int i = 0; i < pseudo_critical_count; ++i) {
        result[1][i] = pseudo_critical_edges_list[i];
    }

    // Clean up temporary allocations
    free(all_edges);
    free(critical_edges_list);
    free(pseudo_critical_edges_list);

    return result;
}