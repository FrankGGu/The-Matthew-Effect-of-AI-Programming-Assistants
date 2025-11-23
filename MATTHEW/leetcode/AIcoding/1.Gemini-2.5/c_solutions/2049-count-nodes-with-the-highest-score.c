#include <stdlib.h>
#include <string.h>

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode** adj;
int* subtree_sizes;
int N_nodes;

int dfs_calculate_size(int u) {
    int current_subtree_size = 1;
    AdjNode* current = adj[u];
    while (current != NULL) {
        current_subtree_size += dfs_calculate_size(current->val);
        current = current->next;
    }
    subtree_sizes[u] = current_subtree_size;
    return current_subtree_size;
}

int countHighestScoreNodes(int* parents, int parentsSize) {
    N_nodes = parentsSize;

    adj = (AdjNode**)calloc(N_nodes, sizeof(AdjNode*));
    for (int i = 0; i < N_nodes; ++i) {
        if (parents[i] != -1) {
            AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
            newNode->val = i;
            newNode->next = adj[parents[i]];
            adj[parents[i]] = newNode;
        }
    }

    subtree_sizes = (int*)malloc(N_nodes * sizeof(int));
    dfs_calculate_size(0);

    long long max_score = 0;
    int count_max_score = 0;

    for (int i = 0; i < N_nodes; ++i) {
        long long current_score = 1;
        long long remaining_nodes_for_multiplication = N_nodes - 1;

        AdjNode* current_child = adj[i];
        while (current_child != NULL) {
            int child_subtree_size = subtree_sizes[current_child->val];
            current_score *= child_subtree_size;
            remaining_nodes_for_multiplication -= child_subtree_size;
            current_child = current_child->next;
        }

        if (remaining_nodes_for_multiplication > 0) {
            current_score *= remaining_nodes_for_multiplication;
        }

        if (current_score > max_score) {
            max_score = current_score;
            count_max_score = 1;
        } else if (current_score == max_score) {
            count_max_score++;
        }
    }

    for (int i = 0; i < N_nodes; ++i) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    free(subtree_sizes);

    return count_max_score;
}