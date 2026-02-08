#include <stdlib.h>
#include <limits.h>
#include "uthash.h"

typedef struct {
    int val;
    int neighbors[2];
    int neighbor_count;
    UT_hash_handle hh;
} AdjNode;

AdjNode *find_node(AdjNode **head, int val) {
    AdjNode *s;
    HASH_FIND_INT(*head, &val, s);
    return s;
}

void add_neighbor(AdjNode **head, int u, int v) {
    AdjNode *node = find_node(head, u);
    if (node == NULL) {
        node = (AdjNode *)malloc(sizeof(AdjNode));
        node->val = u;
        node->neighbor_count = 0;
        HASH_ADD_INT(*head, val, node);
    }
    node->neighbors[node->neighbor_count++] = v;
}

int* restoreArray(int** adjacentPairs, int adjacentPairsSize, int* adjacentPairsColSize, int* returnSize) {
    AdjNode *adj_map = NULL;

    for (int i = 0; i < adjacentPairsSize; i++) {
        int u = adjacentPairs[i][0];
        int v = adjacentPairs[i][1];
        add_neighbor(&adj_map, u, v);
        add_neighbor(&adj_map, v, u);
    }

    int start_val = 0;
    AdjNode *current_node, *tmp;
    HASH_ITER(hh, adj_map, current_node, tmp) {
        if (current_node->neighbor_count == 1) {
            start_val = current_node->val;
            break;
        }
    }

    *returnSize = adjacentPairsSize + 1;
    int *restoredArray = (int *)malloc(sizeof(int) * (*returnSize));

    int current_val = start_val;
    int prev_val = INT_MIN;

    for (int i = 0; i < *returnSize; i++) {
        restoredArray[i] = current_val;

        if (i == *returnSize - 1) {
            break;
        }

        AdjNode *node = find_node(&adj_map, current_val);

        int next_val;
        if (node->neighbors[0] == prev_val) {
            next_val = node->neighbors[1];
        } else {
            next_val = node->neighbors[0];
        }

        prev_val = current_val;
        current_val = next_val;
    }

    HASH_ITER(hh, adj_map, current_node, tmp) {
        HASH_DEL(adj_map, current_node);
        free(current_node);
    }

    return restoredArray;
}