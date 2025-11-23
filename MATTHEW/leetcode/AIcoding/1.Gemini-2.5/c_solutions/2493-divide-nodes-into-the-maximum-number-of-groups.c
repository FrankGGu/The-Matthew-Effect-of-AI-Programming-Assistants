#include <stdlib.h> // For abs()

#define MAX_NODES 500
#define MAX_EDGES 10000 // Number of edges given in input
#define MAX_ADJ_LIST_SIZE (2 * MAX_EDGES) // Each edge (u,v) adds two entries to adjacency list

int head[MAX_NODES];
int next_edge[MAX_ADJ_LIST_SIZE];
int to_node[MAX_ADJ_LIST_SIZE];
int edge_idx;

int dist[MAX_NODES]; // Stores distance from source, also indicates visited status (-1 means unvisited)
int q[MAX_NODES];
int q_front, q_rear;

void add_edge(int u, int v) {
    to_node[edge_idx] = v;
    next_edge[edge_idx] = head[u];
    head[u] = edge_idx;
    edge_idx++;
}

int maxGroups(int n, int** edges, int edgesSize, int* edgesColSize) {
    // Initialize adjacency list
    for (int i = 0; i < n; i++) {
        head[i] = -1;
    }
    edge_idx = 0;

    // Build adjacency list
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
        add_edge(v, u);
    }

    // Initialize dist array (marks all nodes as unvisited)
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }

    int total_groups = 0;

    // Iterate through all nodes to find connected components
    for (int i = 0; i < n; i++) {
        if (dist[i] == -1) { // Node i is part of a new unvisited component
            q_front = 0;
            q_rear = 0;

            q[q_rear++] = i;
            dist[i] = 0;
            int max_dist_in_component = 0;

            while (q_front < q_rear) {
                int u = q[q_front++];
                if (dist[u] > max_dist_in_component) {
                    max_dist_in_component = dist[u];
                }

                for (int e = head[u]; e != -1; e = next_edge[e]) {
                    int v = to_node[e];
                    if (dist[v] == -1) { // v is unvisited
                        dist[v] = dist[u] + 1;
                        q[q_rear++] = v;
                    } else { // v is visited
                        // Check bipartiteness condition: |dist[u] - dist[v]| must be 1
                        // If dist[u] and dist[v] are the same, or differ by more than 1,
                        // it implies an odd cycle or a violation of group adjacency.
                        if (abs(dist[u] - dist[v]) != 1) {
                            return -1; // Not bipartite (odd cycle detected)
                        }
                    }
                }
            }
            // If the component is bipartite, add its required groups
            // A component with max_dist_in_component requires (max_dist_in_component + 1) groups
            // (e.g., if max_dist is 0, it needs 1 group; if max_dist is 1, it needs 2 groups).
            total_groups += (max_dist_in_component + 1);
        }
    }

    return total_groups;
}