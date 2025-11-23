#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MAX

void calculate_distances(int n, int* edges, int start_node, int* distances) {
    // Initialize all distances to -1, indicating unreachable
    for (int i = 0; i < n; i++) {
        distances[i] = -1;
    }

    int current_node = start_node;
    int dist = 0;

    // Traverse the path from start_node
    // The loop continues as long as the current_node is valid (not -1)
    // and has not been visited yet in this traversal (distances[current_node] == -1)
    while (current_node != -1 && distances[current_node] == -1) {
        distances[current_node] = dist; // Set distance for current_node
        current_node = edges[current_node]; // Move to the next node
        dist++; // Increment distance
    }
}

int findClosestMeetingNode(int* edges, int edgesSize, int node1, int node2) {
    int n = edgesSize;

    // Allocate memory for distance arrays
    int* dist1 = (int*)malloc(n * sizeof(int));
    int* dist2 = (int*)malloc(n * sizeof(int));

    // Calculate distances from node1 to all reachable nodes
    calculate_distances(n, edges, node1, dist1);

    // Calculate distances from node2 to all reachable nodes
    calculate_distances(n, edges, node2, dist2);

    int min_max_dist = INT_MAX; // Stores the minimum of the maximum distances found so far
    int result_node = -1;       // Stores the index of the node that achieves min_max_dist

    // Iterate through all possible nodes to find the meeting node
    for (int i = 0; i < n; i++) {
        // A node 'i' is a potential meeting node if it's reachable from both node1 and node2
        if (dist1[i] != -1 && dist2[i] != -1) {
            // Calculate the maximum distance to node 'i' from either node1 or node2
            int current_max_dist = (dist1[i] > dist2[i]) ? dist1[i] : dist2[i];

            // If this maximum distance is less than the current minimum maximum distance,
            // update min_max_dist and result_node.
            // If current_max_dist is equal to min_max_dist, we keep the smaller index
            // because we iterate from 0 to n-1, so the first node found with that
            // minimum max distance will have the smallest index.
            if (current_max_dist < min_max_dist) {
                min_max_dist = current_max_dist;
                result_node = i;
            }
        }
    }

    // Free dynamically allocated memory to prevent memory leaks
    free(dist1);
    free(dist2);

    return result_node;
}