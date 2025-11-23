#include <limits.h>
#include <stdlib.h>

typedef struct AdjNode {
    int to_city;
    int travel_time;
    struct AdjNode* next;
} AdjNode;

void add_edge(AdjNode* adj[], int u, int v, int time) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->to_city = v;
    newNode->travel_time = time;
    newNode->next = adj[u];
    adj[u] = newNode;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minCost(int maxTime, int* passingCosts, int passingCostsSize, int** roads, int roadsSize, int* roadsColSize) {
    int n = passingCostsSize;

    // Adjacency list: array of pointers to AdjNode
    AdjNode* adj[n];
    for (int i = 0; i < n; ++i) {
        adj[i] = NULL;
    }

    // Build adjacency list (bidirectional roads)
    for (int i = 0; i < roadsSize; ++i) {
        int u = roads[i][0];
        int v = roads[i][1];
        int time = roads[i][2];
        add_edge(adj, u, v, time);
        add_edge(adj, v, u, time);
    }

    // dp[city][time] = minimum cost to reach 'city' at 'time'
    // Allocate dp table dynamically
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; ++i) {
        dp[i] = (int*)malloc((maxTime + 1) * sizeof(int));
        for (int j = 0; j <= maxTime; ++j) {
            dp[i][j] = INT_MAX; // Initialize with a large value representing infinity
        }
    }

    // Base case: Start at city 0 at time 0
    dp[0][0] = passingCosts[0];

    // Iterate through time
    for (int t = 0; t <= maxTime; ++t) {
        // Iterate through cities
        for (int u = 0; u < n; ++u) {
            if (dp[u][t] == INT_MAX) {
                continue; // Cannot reach city u at time t with a finite cost
            }

            // Explore neighbors of city u
            AdjNode* current = adj[u];
            while (current != NULL) {
                int v = current->to_city;
                int travelTime = current->travel_time;

                // Check if traveling to neighbor v is within maxTime
                if (t + travelTime <= maxTime) {
                    // Calculate new cost to reach city v
                    // dp[u][t] is the cost to reach city u (including passingCosts[u])
                    // passingCosts[v] is the cost for passing city v
                    int new_cost = dp[u][t] + passingCosts[v];

                    // Update dp[v][t + travelTime] if a cheaper path is found
                    if (new_cost < dp[v][t + travelTime]) {
                        dp[v][t + travelTime] = new_cost;
                    }
                }
                current = current->next;
            }
        }
    }

    // Find the minimum cost to reach the destination city (n-1) within maxTime
    int min_total_cost = INT_MAX;
    for (int t = 0; t <= maxTime; ++t) {
        min_total_cost = min(min_total_cost, dp[n - 1][t]);
    }

    // Free allocated memory for dp table
    for (int i = 0; i < n; ++i) {
        free(dp[i]);
    }
    free(dp);

    // Free allocated memory for adjacency list
    for (int i = 0; i < n; ++i) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }

    // If min_total_cost is still INT_MAX, destination is unreachable
    return (min_total_cost == INT_MAX) ? -1 : min_total_cost;
}