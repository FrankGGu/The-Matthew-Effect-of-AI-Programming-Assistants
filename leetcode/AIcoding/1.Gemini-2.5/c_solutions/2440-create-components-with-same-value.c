#include <stdlib.h>

#define MAX_NODES 10001

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj[MAX_NODES];

void addEdge(int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;

    newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = u;
    newNode->next = adj[v];
    adj[v] = newNode;
}

int dfs(int u, int parent, int target_sum, int* values, int* cut_count) {
    int current_subtree_sum = values[u];
    AdjNode* current = adj[u];
    while (current != NULL) {
        int v = current->val;
        if (v != parent) {
            current_subtree_sum += dfs(v, u, target_sum, values, cut_count);
        }
        current = current->next;
    }

    if (current_subtree_sum == target_sum) {
        (*cut_count)++;
        return 0;
    }
    return current_subtree_sum;
}

int createComponentsWithSameValue(int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize) {
    for (int i = 0; i < valuesSize; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        addEdge(edges[i][0], edges[i][1]);
    }

    long long total_sum = 0;
    for (int i = 0; i < valuesSize; i++) {
        total_sum += values[i];
    }

    int result = 1;

    for (int k = valuesSize; k >= 1; k--) {
        if (total_sum % k == 0) {
            int target_sum = total_sum / k;
            int cut_count = 0;

            int remaining_sum_at_root = dfs(0, -1, target_sum, values, &cut_count);

            if (remaining_sum_at_root == 0 && cut_count == k) {
                result = k;
                break;
            }
        }
    }

    for (int i = 0; i < valuesSize; i++) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }

    return result;
}