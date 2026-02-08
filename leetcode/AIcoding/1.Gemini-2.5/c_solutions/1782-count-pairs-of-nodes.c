#include <stdlib.h>
#include <string.h>

struct Edge {
    int u, v;
};

int compareEdges(const void* a, const void* b) {
    struct Edge* edgeA = (struct Edge*)a;
    struct Edge* edgeB = (struct Edge*)b;
    if (edgeA->u != edgeB->u) {
        return edgeA->u - edgeB->u;
    }
    return edgeA->v - edgeB->v;
}

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* countPairsOfNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* queries, int queriesSize, int* returnSize) {
    // 1. Calculate degrees for each node
    // degree[i] stores the degree of node i. Nodes are 1-indexed.
    int* degree = (int*)calloc(n + 1, sizeof(int));

    // 2. Store (u,v) pairs and their counts for direct edges
    // First, create a temporary list of sorted edges (u,v) for consolidation
    struct Edge* temp_edges = (struct Edge*)malloc(edgesSize * sizeof(struct Edge));

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];

        degree[u]++;
        degree[v]++;

        // Ensure u < v for consistent storage
        if (u > v) {
            int temp = u;
            u = v;
            v = temp;
        }
        temp_edges[i] = (struct Edge){u, v};
    }

    // Sort temporary edges to group identical (u,v) pairs
    qsort(temp_edges, edgesSize, sizeof(struct Edge), compareEdges);

    // Consolidate into adj_counts_list (distinct (u,v) pairs and their counts)
    // Max possible distinct pairs is edgesSize
    struct AdjCount {
        int u, v, count;
    };
    struct AdjCount* adj_counts_list = (struct AdjCount*)malloc(edgesSize * sizeof(struct AdjCount));
    int adj_list_idx = 0; // Number of distinct (u,v) pairs with edges

    if (edgesSize > 0) {
        adj_counts_list[0] = (struct AdjCount){temp_edges[0].u, temp_edges[0].v, 1};
        for (int i = 1; i < edgesSize; ++i) {
            if (temp_edges[i].u == adj_counts_list[adj_list_idx].u && temp_edges[i].v == adj_counts_list[adj_list_idx].v) {
                adj_counts_list[adj_list_idx].count++;
            } else {
                adj_list_idx++;
                adj_counts_list[adj_list_idx] = (struct AdjCount){temp_edges[i].u, temp_edges[i].v, 1};
            }
        }
        adj_list_idx++; // Total count of distinct pairs
    }
    free(temp_edges);

    // 3. Compute initial_pair_sums (frequency of degree[u] + degree[v] for all u < v)
    // Max possible sum of degrees is 2 * (n-1).
    int max_sum_degree = 2 * (n - 1);
    int* initial_pair_sums = (int*)calloc(max_sum_degree + 1, sizeof(int));

    // Create a frequency array for degrees
    int* degree_counts = (int*)calloc(n, sizeof(int)); // Max degree is n-1
    for (int i = 1; i <= n; ++i) {
        degree_counts[degree[i]]++;
    }

    // Iterate through all possible degree combinations to populate initial_pair_sums
    for (int d1 = 0; d1 < n; ++d1) {
        if (degree_counts[d1] == 0) continue;
        for (int d2 = d1; d2 < n; ++d2) {
            if (degree_counts[d2] == 0) continue;
            if (d1 == d2) {
                initial_pair_sums[d1 + d2] += degree_counts[d1] * (degree_counts[d1] - 1) / 2;
            } else {
                initial_pair_sums[d1 + d2] += degree_counts[d1] * degree_counts[d2];
            }
        }
    }
    free(degree_counts);

    // 4. Create final_pair_sums by adjusting initial_pair_sums
    // final_pair_sums[k] = count of pairs (u,v) with score = degree[u]+degree[v]-adj_counts[u][v] = k
    int* final_pair_sums = (int*)calloc(max_sum_degree + 1, sizeof(int));
    memcpy(final_pair_sums, initial_pair_sums, (max_sum_degree + 1) * sizeof(int));
    free(initial_pair_sums);

    for (int i = 0; i < adj_list_idx; ++i) {
        int u = adj_counts_list[i].u;
        int v = adj_counts_list[i].v;
        int count = adj_counts_list[i].count;

        int base_sum = degree[u] + degree[v];
        int adjusted_sum = base_sum - count;

        // This pair was initially counted at base_sum, but its actual score is adjusted_sum.
        // So decrement count at base_sum and increment at adjusted_sum.
        final_pair_sums[base_sum]--;
        final_pair_sums[adjusted_sum]++;
    }
    free(adj_counts_list);
    free(degree);

    // 5. Compute suffix sums of final_pair_sums
    // suffix_sum_final_pair_sums[k] = count of pairs (u,v) with score >= k
    // The maximum possible score is max_sum_degree.
    // Queries can be up to edgesSize-1, so q+1 can be edgesSize.
    // edgesSize can be 10^5, while max_sum_degree can be ~4*10^4.
    // So the suffix sum array needs to be large enough to cover max(max_sum_degree, edgesSize) + 2.
    int max_index_for_query = (edgesSize > max_sum_degree) ? edgesSize : max_sum_degree;
    int* suffix_sum_final_pair_sums = (int*)calloc(max_index_for_query + 2, sizeof(int));

    for (int i = max_sum_degree; i >= 0; --i) {
        suffix_sum_final_pair_sums[i] = final_pair_sums[i];
        if (i + 1 <= max_index_for_query + 1) { // Ensure index is within bounds
             suffix_sum_final_pair_sums[i] += suffix_sum_final_pair_sums[i+1];
        }
    }
    free(final_pair_sums);

    // 6. Answer queries
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; ++i) {
        int q = queries[i];
        // We need pairs with score strictly greater than q, which means score >= q + 1.
        // If q + 1 is out of bounds (larger than max_index_for_query), the count is 0.
        if (q + 1 > max_index_for_query) {
            ans[i] = 0;
        } else {
            ans[i] = suffix_sum_final_pair_sums[q + 1];
        }
    }
    free(suffix_sum_final_pair_sums);

    return ans;
}