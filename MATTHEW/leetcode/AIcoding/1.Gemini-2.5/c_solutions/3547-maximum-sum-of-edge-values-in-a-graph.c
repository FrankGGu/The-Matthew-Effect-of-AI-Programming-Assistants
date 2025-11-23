#include <stdlib.h> // For malloc, calloc, free

typedef struct AdjNode {
    int neighbor;
    struct AdjNode* next;
} AdjNode;

long long maximumValueSum(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize, int k) {
    // Build adjacency list
    AdjNode** adj = (AdjNode**) calloc(numsSize, sizeof(AdjNode*)); // calloc initializes pointers to NULL

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        // Add v to u's list
        AdjNode* newNodeU = (AdjNode*) malloc(sizeof(AdjNode));
        newNodeU->neighbor = v;
        newNodeU->next = adj[u];
        adj[u] = newNodeU;

        // Add u to v's list
        AdjNode* newNodeV = (AdjNode*) malloc(sizeof(AdjNode));
        newNodeV->neighbor = u;
        newNodeV->next = adj[v];
        adj[v] = newNodeV;
    }

    // Calculate initial sum S
    long long initial_sum = 0;
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        initial_sum += (long long)(nums[u] ^ nums[v]);
    }

    // Find maximum delta_x (change in total sum if node x is chosen for operation)
    // Initialize max_delta to 0, representing the option of not performing any operation
    long long max_delta = 0; 

    for (int x = 0; x < numsSize; x++) {
        long long current_delta_x = 0;
        AdjNode* current = adj[x];
        while (current != NULL) {
            int y = current->neighbor;
            // Calculate change for edge (x, y): (new_value - old_value)
            current_delta_x += (long long)((nums[x] ^ k ^ nums[y]) - (nums[x] ^ nums[y]));
            current = current->next;
        }
        if (current_delta_x > max_delta) {
            max_delta = current_delta_x;
        }
    }

    // The maximum total value is the initial sum plus the maximum possible positive delta
    long long result = initial_sum + max_delta;

    // Free allocated memory for adjacency list
    for (int i = 0; i < numsSize; i++) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);

    return result;
}