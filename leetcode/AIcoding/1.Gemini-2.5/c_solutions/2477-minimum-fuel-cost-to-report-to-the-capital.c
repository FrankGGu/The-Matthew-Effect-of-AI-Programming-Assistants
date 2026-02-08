#include <stdlib.h>
#include <string.h>

#define MAX_NODES 100005

int head[MAX_NODES];
int next_edge[2 * MAX_NODES]; // Maximum edges in an undirected graph is 2 * (N-1)
int to_node[2 * MAX_NODES];
int edge_count;

long long total_fuel_cost;

void add_edge(int u, int v) {
    to_node[edge_count] = v;
    next_edge[edge_count] = head[u];
    head[u] = edge_count;
    edge_count++;
}

int dfs(int u, int p, int seats) {
    // Each node initially has one representative
    int people_count = 1;

    // Iterate through all neighbors of the current node 'u'
    for (int i = head[u]; i != -1; i = next_edge[i]) {
        int v = to_node[i];
        // Skip the parent node to avoid cycles in DFS
        if (v == p) {
            continue;
        }

        // Recursively call DFS for the child node 'v'
        int child_people = dfs(v, u, seats);
        // Add the people from the child's subtree to the current node's count
        people_count += child_people;

        // Calculate the number of trips needed to transport 'child_people' from 'v' to 'u'
        // This is a ceiling division: (a + b - 1) / b
        long long trips = (child_people + seats - 1) / seats;
        // Each trip from 'v' to 'u' consumes 1 unit of fuel (for that edge)
        total_fuel_cost += trips;
    }

    // Return the total number of people in the subtree rooted at 'u'
    return people_count;
}

long long minimumFuelCost(int n, int** roads, int roadsSize, int* roadsColSize, int seats) {
    // Initialize the global total fuel cost to 0
    total_fuel_cost = 0;

    // Initialize all adjacency list heads to -1 (indicating no edges yet)
    // Only initialize up to n nodes, as nodes are 0 to n-1
    memset(head, -1, sizeof(int) * n);
    // Reset edge count for a new test case
    edge_count = 0;

    // Build the adjacency list from the given roads
    for (int i = 0; i < roadsSize; i++) {
        // Add edge for both directions as the graph is undirected
        add_edge(roads[i][0], roads[i][1]);
        add_edge(roads[i][1], roads[i][0]);
    }

    // Start the DFS from the capital (node 0).
    // The parent of the capital is considered -1 as it has no parent.
    dfs(0, -1, seats);

    // Return the accumulated total fuel cost
    return total_fuel_cost;
}