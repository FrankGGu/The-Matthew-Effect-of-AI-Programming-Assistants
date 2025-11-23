#include <stdlib.h>
#include <string.h> // For memset if using calloc is not an option for matrix initialization

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

void add_edge(AdjNode** adj, int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;
}

int* get_order(int k, int** conditions, int conditionsSize) {
    // adj list for 1-indexed nodes (1 to k)
    // adj[0] is unused, adj[i] corresponds to number i
    AdjNode** adj = (AdjNode**)calloc(k + 1, sizeof(AdjNode*));
    int* in_degree = (int*)calloc(k + 1, sizeof(int));

    for (int i = 0; i < conditionsSize; i++) {
        int u = conditions[i][0];
        int v = conditions[i][1];
        add_edge(adj, u, v);
        in_degree[v]++;
    }

    // Queue for BFS
    int* queue = (int*)malloc(k * sizeof(int));
    int head = 0, tail = 0;

    // Add all nodes with in-degree 0 to the queue
    for (int i = 1; i <= k; i++) {
        if (in_degree[i] == 0) {
            queue[tail++] = i;
        }
    }

    // result_order stores the numbers in topological order
    int* result_order = (int*)malloc(k * sizeof(int));
    int count = 0; // Number of elements in result_order

    while (head < tail) {
        int u = queue[head++];
        result_order[count++] = u;

        AdjNode* current = adj[u];
        while (current != NULL) {
            int v = current->val;
            in_degree[v]--;
            if (in_degree[v] == 0) {
                queue[tail++] = v;
            }
            current = current->next;
        }
    }

    // Free adjacency list memory
    for (int i = 1; i <= k; i++) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    free(in_degree);
    free(queue);

    if (count != k) { // Cycle detected, topological sort not possible for all k numbers
        free(result_order);
        return NULL;
    }

    // Create pos_map: pos_map[num] = its 0-indexed position in the topological order
    // pos_map[0] is unused, pos_map[i] corresponds to number i
    int* pos_map = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i < k; i++) {
        pos_map[result_order[i]] = i;
    }
    free(result_order); // result_order is no longer needed

    return pos_map;
}

int** buildMatrix(int k, int** rowConditions, int rowConditionsSize, int* rowConditionsColSize, int** colConditions, int colConditionsSize, int* colConditionsColSize, int* returnSize, int** returnColumnSizes) {
    // Get the 0-indexed row positions for each number (1 to k)
    int* row_pos = get_order(k, rowConditions, rowConditionsSize);
    if (row_pos == NULL) { // If a cycle is detected in row conditions
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Get the 0-indexed column positions for each number (1 to k)
    int* col_pos = get_order(k, colConditions, colConditionsSize);
    if (col_pos == NULL) { // If a cycle is detected in column conditions
        free(row_pos); // Free previously allocated row_pos
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Allocate the k x k matrix
    int** matrix = (int**)malloc(k * sizeof(int*));
    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        matrix[i] = (int*)calloc(k, sizeof(int)); // calloc initializes all elements to 0
        (*returnColumnSizes)[i] = k;
    }

    // Place numbers 1 to k into the matrix based on their determined row and column positions
    for (int i = 1; i <= k; i++) {
        matrix[row_pos[i]][col_pos[i]] = i;
    }

    // Free the position maps
    free(row_pos);
    free(col_pos);

    *returnSize = k;
    return matrix;
}