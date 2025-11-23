#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

#define INF 1e15L 

long long** dist; 

long long* shortestDistanceAfterRoadAdditionQueries(int n, int** initialRoads, int initialRoadsSize, int* initialRoadsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Allocate distance matrix
    dist = (long long**)malloc(n * sizeof(long long*));
    for (int i = 0; i < n; i++) {
        dist[i] = (long long*)malloc(n * sizeof(long long));
        for (int j = 0; j < n; j++) {
            if (i == j) {
                dist[i][j] = 0; // Distance to self is 0
            } else {
                dist[i][j] = INF; // Initialize all other distances to infinity
            }
        }
    }

    // Process initial roads
    for (int i = 0; i < initialRoadsSize; i++) {
        int u = initialRoads[i][0] - 1; // Convert to 0-indexed
        int v = initialRoads[i][1] - 1; // Convert to 0-indexed
        int w = initialRoads[i][2];
        // Update direct edge weight if new weight is smaller
        if (w < dist[u][v]) { 
            dist[u][v] = w;
            dist[v][u] = w; // Roads are bidirectional
        }
    }

    // Run initial Floyd-Warshall to compute all-pairs shortest paths
    // k is the intermediate node
    for (int k = 0; k < n; k++) {
        // i is the source node
        for (int i = 0; i < n; i++) {
            // j is the destination node
            for (int j = 0; j < n; j++) {
                // Check for INF to prevent overflow and ensure path validity
                if (dist[i][k] != INF && dist[k][j] != INF) { 
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
    }

    // Count type 2 queries to determine the size of the result array
    int query_results_count = 0;
    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 2) { 
            query_results_count++;
        }
    }

    // Allocate memory for the results array
    long long* results = (long long*)malloc(query_results_count * sizeof(long long));
    *returnSize = query_results_count; // Set the return size
    int current_result_idx = 0;

    // Process queries
    for (int q_idx = 0; q_idx < queriesSize; q_idx++) {
        int type = queries[q_idx][0];
        int x = queries[q_idx][1] - 1; // Convert to 0-indexed
        int y = queries[q_idx][2] - 1; // Convert to 0-indexed

        if (type == 1) { // Add road query
            int w = queries[q_idx][3]; // Weight for the new road

            // Update the direct edge weight between x and y
            if (w < dist[x][y]) {
                dist[x][y] = w;
                dist[y][x] = w;
            }

            // Perform incremental Floyd-Warshall updates.
            // After adding/reducing an edge (x, y), all paths i -> j might be improved
            // by passing through x or y. This is equivalent to running the k-loop of 
            // Floyd-Warshall for k=x and then for k=y.

            // First pass: Update paths potentially using x as an intermediate node
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][x] != INF && dist[x][j] != INF) {
                        if (dist[i][x] + dist[x][j] < dist[i][j]) {
                            dist[i][j] = dist[i][x] + dist[x][j];
                        }
                    }
                }
            }

            // Second pass: Update paths potentially using y as an intermediate node
            // This must be done after the x-update, as paths through y might now use
            // a path to/from x that was just updated.
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][y] != INF && dist[y][j] != INF) {
                        if (dist[i][y] + dist[y][j] < dist[i][j]) {
                            dist[i][j] = dist[i][y] + dist[y][j];
                        }
                    }
                }
            }

        } else { // Query shortest distance
            long long d = dist[x][y];
            // If the distance is INF, it means unreachable, return -1.
            results[current_result_idx++] = (d == INF) ? -1 : d; 
        }
    }

    // Free the dynamically allocated memory for the distance matrix
    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);
    dist = NULL; // Good practice to nullify after freeing

    return results; // Caller is responsible for freeing 'results'
}