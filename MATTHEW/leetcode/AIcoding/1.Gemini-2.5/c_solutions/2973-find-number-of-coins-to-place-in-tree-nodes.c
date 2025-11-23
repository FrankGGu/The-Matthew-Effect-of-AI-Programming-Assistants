#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct AdjListNode {
    int dest;
    struct AdjListNode* next;
} AdjListNode;

typedef struct AdjList {
    AdjListNode** head;
} AdjList;

void addEdge(AdjList* graph, int src, int dest) {
    AdjListNode* newNode = (AdjListNode*)malloc(sizeof(AdjListNode));
    newNode->dest = dest;
    newNode->next = graph->head[src];
    graph->head[src] = newNode;

    newNode = (AdjListNode*)malloc(sizeof(AdjListNode));
    newNode->dest = src;
    newNode->next = graph->head[dest];
    graph->head[dest] = newNode;
}

typedef struct SubtreeInfo {
    int count;           // Number of nodes in the subtree
    long long max_vals[3]; // Top 3 largest values in descending order
    long long min_vals[2]; // Top 2 smallest values in ascending order
} SubtreeInfo;

void insert_max(long long* arr, long long val) {
    if (val > arr[0]) {
        arr[2] = arr[1];
        arr[1] = arr[0];
        arr[0] = val;
    } else if (val > arr[1]) {
        arr[2] = arr[1];
        arr[1] = val;
    } else if (val > arr[2]) {
        arr[2] = val;
    }
}

void insert_min(long long* arr, long long val) {
    if (val < arr[0]) {
        arr[1] = arr[0];
        arr[0] = val;
    } else if (val < arr[1]) {
        arr[1] = val;
    }
}

SubtreeInfo dfs(int u, int p, int* values, AdjList* graph, long long* ans) {
    SubtreeInfo current_info;
    current_info.count = 1;

    // Initialize max_vals with LLONG_MIN (smallest possible long long)
    current_info.max_vals[0] = LLONG_MIN;
    current_info.max_vals[1] = LLONG_MIN;
    current_info.max_vals[2] = LLONG_MIN;

    // Initialize min_vals with LLONG_MAX (largest possible long long)
    current_info.min_vals[0] = LLONG_MAX;
    current_info.min_vals[1] = LLONG_MAX;

    // Add current node's value to its own subtree info
    insert_max(current_info.max_vals, values[u]);
    insert_min(current_info.min_vals, values[u]);

    // Iterate through neighbors
    AdjListNode* temp = graph->head[u];
    while (temp != NULL) {
        int v = temp->dest;
        if (v != p) { // Avoid going back to parent
            SubtreeInfo child_info = dfs(v, u, values, graph, ans); // Recurse for child

            current_info.count += child_info.count; // Update total count

            // Merge child's top 3 max values into current node's max_vals
            insert_max(current_info.max_vals, child_info.max_vals[0]);
            insert_max(current_info.max_vals, child_info.max_vals[1]);
            insert_max(current_info.max_vals, child_info.max_vals[2]);

            // Merge child's top 2 min values into current node's min_vals
            insert_min(current_info.min_vals, child_info.min_vals[0]);
            insert_min(current_info.min_vals, child_info.min_vals[1]);
        }
        temp = temp->next;
    }

    // Calculate coins for the current node u based on its subtree info
    if (current_info.count < 3) {
        ans[u] = 1; // If less than 3 nodes, place 1 coin
    } else {
        long long prod1 = 0; // Product of 3 largest values
        long long prod2 = 0; // Product of 2 smallest and 1 largest value

        // Check if there are enough valid numbers to form prod1
        if (current_info.max_vals[2] != LLONG_MIN) {
            prod1 = current_info.max_vals[0] * current_info.max_vals[1] * current_info.max_vals[2];
        }

        // Check if there are enough valid numbers to form prod2
        if (current_info.min_vals[1] != LLONG_MAX && current_info.max_vals[0] != LLONG_MIN) {
            prod2 = current_info.min_vals[0] * current_info.min_vals[1] * current_info.max_vals[0];
        }

        // The number of coins is the maximum of the two products, or 0 if negative
        long long max_prod = 0;
        if (prod1 > max_prod) max_prod = prod1;
        if (prod2 > max_prod) max_prod = prod2;

        ans[u] = max_prod;
    }

    return current_info; // Return current subtree's aggregated information
}

long long* numberOfCoins(int n, int** edges, int edgesSize, int* edgesColSize, int* values, int* returnSize) {
    // Build adjacency list
    AdjList graph;
    graph.head = (AdjListNode**)calloc(n, sizeof(AdjListNode*)); // Initialize all heads to NULL

    for (int i = 0; i < edgesSize; ++i) {
        addEdge(&graph, edges[i][0], edges[i][1]);
    }

    long long* ans = (long long*)calloc(n, sizeof(long long)); // Allocate memory for results
    *returnSize = n; // Set the return size

    // Start DFS from node 0 (assuming tree is connected and 0 is a valid root)
    dfs(0, -1, values, &graph, ans);

    // Free memory allocated for the adjacency list
    for (int i = 0; i < n; ++i) {
        AdjListNode* current = graph.head[i];
        while (current != NULL) {
            AdjListNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(graph.head);

    return ans; // Return the array of coin counts
}