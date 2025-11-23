#include <stdlib.h> // For abs
#include <limits.h> // For INT_MAX
#include <string.h> // For memset

typedef struct {
    int x;
    int y;
} Point;

int get_manhattan_dist(Point p1, Point p2) {
    return abs(p1.x - p2.x) + abs(p1.y - p2.y);
}

int min(int a, int b) {
    return a < b ? a : b;
}

#define MAX_UNIQUE_POINTS 402
#define MAX_COORD 1001 // Coordinates up to 1000 (0 to 1000)

int point_to_idx[MAX_COORD][MAX_COORD];
Point all_points[MAX_UNIQUE_POINTS];
int num_unique_points_global;

int get_point_index(int x, int y) {
    if (point_to_idx[x][y] == -1) {
        point_to_idx[x][y] = num_unique_points_global;
        all_points[num_unique_points_global].x = x;
        all_points[num_unique_points_global].y = y;
        num_unique_points_global++;
    }
    return point_to_idx[x][y];
}

int minCost(int* target, int targetSize, int** specialRoads, int specialRoadsSize, int* specialRoadsColSize) {
    // Reset global state for each test case (important for LeetCode's multiple test cases)
    memset(point_to_idx, -1, sizeof(point_to_idx));
    num_unique_points_global = 0;

    // 1. Collect all unique points and map them to indices
    int start_idx = get_point_index(0, 0);
    int target_idx = get_point_index(target[0], target[1]);

    // Store special road details temporarily.
    // This is needed because special roads might involve points not yet indexed,
    // and we need to ensure all points are indexed before building the graph matrix.
    typedef struct {
        int from_idx;
        int to_idx;
        int cost;
    } SpecialRoadInfo;

    SpecialRoadInfo temp_special_roads[specialRoadsSize];

    for (int i = 0; i < specialRoadsSize; ++i) {
        int x1 = specialRoads[i][0];
        int y1 = specialRoads[i][1];
        int x2 = specialRoads[i][2];
        int y2 = specialRoads[i][3];
        int cost = specialRoads[i][4];

        int idx1 = get_point_index(x1, y1);
        int idx2 = get_point_index(x2, y2);

        temp_special_roads[i].from_idx = idx1;
        temp_special_roads[i].to_idx = idx2;
        temp_special_roads[i].cost = cost;
    }

    int num_nodes = num_unique_points_global;

    // 2. Build the adjacency matrix for the graph
    // graph[i][j] stores the minimum cost to go from point i to point j.
    int graph[MAX_UNIQUE_POINTS][MAX_UNIQUE_POINTS];

    for (int i = 0; i < num_nodes; ++i) {
        for (int j = 0; j < num_nodes; ++j) {
            if (i == j) {
                graph[i][j] = 0;
            } else {
                graph[i][j] = get_manhattan_dist(all_points[i], all_points[j]);
            }
        }
    }

    // Apply special roads. If a special road offers a cheaper path, update the graph.
    for (int i = 0; i < specialRoadsSize; ++i) {
        int from = temp_special_roads[i].from_idx;
        int to = temp_special_roads[i].to_idx;
        int cost = temp_special_roads[i].cost;
        graph[from][to] = min(graph[from][to], cost);
    }

    // 3. Dijkstra's Algorithm (O(V^2) implementation)
    int dist[MAX_UNIQUE_POINTS];
    _Bool visited[MAX_UNIQUE_POINTS]; // Use _Bool for boolean type in C99

    for (int i = 0; i < num_nodes; ++i) {
        dist[i] = INT_MAX; // Initialize distances to infinity
        visited[i] = 0;    // Initialize all nodes as unvisited
    }

    dist[start_idx] = 0; // Distance to the start node is 0

    // Loop num_nodes times to find the shortest path to each node
    for (int count = 0; count < num_nodes; ++count) {
        int u = -1;
        int min_d = INT_MAX;

        // Find the unvisited node with the minimum distance
        for (int v = 0; v < num_nodes; ++v) {
            if (!visited[v] && dist[v] < min_d) {
                min_d = dist[v];
                u = v;
            }
        }

        // If no reachable unvisited node is found, or if the target has been reached, break.
        if (u == -1 || u == target_idx) {
            break;
        }

        visited[u] = 1; // Mark the selected node as visited

        // Update distances to adjacent nodes
        for (int v = 0; v < num_nodes; ++v) {
            // If v is not visited, and there is an edge from u to v
            // and a shorter path to v is found through u
            if (!visited[v] && graph[u][v] != INT_MAX) { 
                // Check for potential overflow before addition
                if (dist[u] != INT_MAX && (long long)dist[u] + graph[u][v] < dist[v]) {
                    dist[v] = dist[u] + graph[u][v];
                }
            }
        }
    }

    return dist[target_idx];
}