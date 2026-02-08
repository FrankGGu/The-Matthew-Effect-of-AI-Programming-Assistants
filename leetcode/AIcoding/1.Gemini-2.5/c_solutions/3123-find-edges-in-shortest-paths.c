#include <stdlib.h>
#include <stdbool.h>
#include <limits.h> // For LLONG_MAX

#define MAX_NODES 100005
#define INF LLONG_MAX

typedef struct {
    int to;
    int weight;
    int original_idx; // Only used for the forward graph to store original edge index
} Edge;

typedef struct {
    long long dist;
    int node;
} PQNode;

Edge* adj[MAX_NODES];
int adj_sizes[MAX_NODES];
int adj_caps[MAX_NODES];

Edge* adj_rev[MAX_NODES]; // For reversed graph, original_idx is not needed
int adj_rev_sizes[MAX_NODES];
int adj_rev_caps[MAX_NODES];

long long dist_from_src[MAX_NODES];
long long dist_to_dest[MAX_NODES];

PQNode pq[MAX_NODES]; // Max nodes in PQ at any time
int pq_size;

void pq_push(long long dist, int node) {
    if (pq_size >= MAX_NODES) {
        // This case should ideally not happen if MAX_NODES is set correctly
        // and graph properties are within limits.
        return;
    }
    pq[pq_size].dist = dist;
    pq[pq_size].node = node;
    int current = pq_size;
    pq_size++;

    while (current > 0) {
        int parent = (current - 1) / 2;
        if (pq[current].dist < pq[parent].dist) {
            PQNode temp = pq[current];
            pq[current] = pq[parent];
            pq[parent] = temp;
            current = parent;
        } else {
            break;
        }
    }
}

PQNode pq_pop() {
    PQNode min_node = pq[0];
    pq_size--;
    if (pq_size > 0) {
        pq[0] = pq[pq_size];
        int current = 0;
        while (true) {
            int left_child = 2 * current + 1;
            int right_child = 2 * current + 2;
            int smallest = current;

            if (left_child < pq_size && pq[left_child].dist < pq[smallest].dist) {
                smallest = left_child;
            }
            if (right_child < pq_size && pq[right_child].dist < pq[smallest].dist) {
                smallest = right_child;
            }

            if (smallest != current) {
                PQNode temp = pq[current];
                pq[current] = pq[smallest];
                pq[smallest] = temp;
                current = smallest;
            } else {
                break;
            }
        }
    }
    return min_node;
}

bool pq_is_empty() {
    return pq_size == 0;
}

void add_edge(Edge** graph_adj, int* graph_sizes, int* graph_caps, int u, int v, int w, int original_idx) {
    if (graph_sizes[u] == graph_caps[u]) {
        graph_caps[u] = graph_caps[u] == 0 ? 4 : graph_caps[u] * 2; // Start with 4, then double
        graph_adj[u] = (Edge*)realloc(graph_adj[u], graph_caps[u] * sizeof(Edge));
        if (graph_adj[u] == NULL) {
            // Handle realloc failure, e.g., by exiting or returning an error
            exit(EXIT_FAILURE); 
        }
    }
    graph_adj[u][graph_sizes[u]].to = v;
    graph_adj[u][graph_sizes[u]].weight = w;
    graph_adj[u][graph_sizes[u]].original_idx = original_idx;
    graph_sizes[u]++;
}

void dijkstra(int start_node, int n_nodes, Edge** graph_adj, int* graph_sizes, long long* distances) {
    for (int i = 0; i < n_nodes; ++i) {
        distances[i] = INF;
    }
    distances[start_node] = 0;

    pq_size = 0; // Reset priority queue
    pq_push(0, start_node);

    while (!pq_is_empty()) {
        PQNode current = pq_pop();
        long long d = current.dist;
        int u = current.node;

        if (d > distances[u]) {
            continue;
        }

        for (int i = 0; i < graph_sizes[u]; ++i) {
            Edge edge = graph_adj[u][i];
            int v = edge.to;
            int weight = edge.weight;

            if (distances[u] != INF && distances[u] + weight < distances[v]) {
                distances[v] = distances[u] + weight;
                pq_push(distances[v], v);
            }
        }
    }
}

bool* findEdgesInShortestPaths(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    // Initialize adjacency lists
    for (int i = 0; i < n; ++i) {
        adj[i] = NULL;
        adj_sizes[i] = 0;
        adj_caps[i] = 0;
        adj_rev[i] = NULL;
        adj_rev_sizes[i] = 0;
        adj_rev_caps[i] = 0;
    }

    // Build graphs
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        // Add edges to the forward graph (adj)
        add_edge(adj, adj_sizes, adj_caps, u, v, w, i);
        add_edge(adj, adj_sizes, adj_caps, v, u, w, i); // Undirected graph

        // Add edges to the reversed graph (adj_rev)
        // For an undirected edge (u,v,w), it means there's a path u->v and v->u.
        // To find shortest paths TO destination (n-1), we run Dijkstra FROM n-1
        // on a graph where all edges are reversed.
        // If an original edge is u->v, its reverse is v->u.
        // So, for (u,v,w), we add (v,u,w) to adj_rev.
        // And for (v,u,w), we add (u,v,w) to adj_rev.
        // Effectively, adj_rev is the same as adj for an undirected graph.
        add_edge(adj_rev, adj_rev_sizes, adj_rev_caps, v, u, w, -1); // original_idx not needed for rev graph
        add_edge(adj_rev, adj_rev_sizes, adj_rev_caps, u, v, w, -1); // original_idx not needed for rev graph
    }

    // Run Dijkstra from source (0)
    dijkstra(0, n, adj, adj_sizes, dist_from_src);

    // Run Dijkstra from destination (n-1) on the reversed graph
    // This effectively computes shortest distances from any node to n-1 in the original graph.
    dijkstra(n - 1, n, adj_rev, adj_rev_sizes, dist_to_dest);

    // Allocate result array
    bool* result = (bool*)calloc(edgesSize, sizeof(bool));
    if (result == NULL) {
        exit(EXIT_FAILURE);
    }
    *returnSize = edgesSize;

    // Check each original edge
    long long shortest_path_len = dist_from_src[n - 1];

    if (shortest_path_len == INF) { // If no path exists from 0 to n-1, no edges are in a shortest path
        // All results are already false due to calloc
    } else {
        for (int i = 0; i < edgesSize; ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];

            // An edge (u, v) with weight w is part of a shortest path from 0 to n-1
            // if the path 0 -> u -> v -> n-1 has length equal to the shortest path length,
            // OR if the path 0 -> v -> u -> n-1 has length equal to the shortest path length
            // (since the graph is undirected, the edge can be traversed in either direction).

            // Check path 0 -> u -> v -> n-1
            if (dist_from_src[u] != INF && dist_to_dest[v] != INF &&
                dist_from_src[u] + w + dist_to_dest[v] == shortest_path_len) {
                result[i] = true;
            }
            // Check path 0 -> v -> u -> n-1
            if (dist_from_src[v] != INF && dist_to_dest[u] != INF &&
                dist_from_src[v] + w + dist_to_dest[u] == shortest_path_len) {
                result[i] = true;
            }
        }
    }

    // Free dynamically allocated adjacency lists
    for (int i = 0; i < n; ++i) {
        free(adj[i]);
        free(adj_rev[i]);
    }

    return result;
}