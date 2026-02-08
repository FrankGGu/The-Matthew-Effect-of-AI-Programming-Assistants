#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* findMinHeightTrees(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    if (n == 1) {
        *returnSize = 1;
        int* result = (int*)malloc(sizeof(int));
        result[0] = 0;
        return result;
    }

    int* degree = (int*)calloc(n, sizeof(int));
    struct ListNode** graph = (struct ListNode**)calloc(n, sizeof(struct ListNode*));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        degree[u]++;
        degree[v]++;

        struct ListNode* nodeU = (struct ListNode*)malloc(sizeof(struct ListNode));
        nodeU->val = v;
        nodeU->next = graph[u];
        graph[u] = nodeU;

        struct ListNode* nodeV = (struct ListNode*)malloc(sizeof(struct ListNode));
        nodeV->val = u;
        nodeV->next = graph[v];
        graph[v] = nodeV;
    }

    int* leaves = (int*)malloc(n * sizeof(int));
    int leavesSize = 0;

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1) {
            leaves[leavesSize++] = i;
        }
    }

    while (n > 2) {
        n -= leavesSize;
        int newLeavesSize = 0;

        for (int i = 0; i < leavesSize; i++) {
            int leaf = leaves[i];
            for (struct ListNode* node = graph[leaf]; node != NULL; node = node->next) {
                int neighbor = node->val;
                degree[neighbor]--;
                if (degree[neighbor] == 1) {
                    leaves[newLeavesSize++] = neighbor;
                }
            }
        }
        leavesSize = newLeavesSize;
    }

    *returnSize = leavesSize;
    int* result = (int*)malloc(leavesSize * sizeof(int));
    for (int i = 0; i < leavesSize; i++) {
        result[i] = leaves[i];
    }

    free(degree);
    for (int i = 0; i < n; i++) {
        struct ListNode* node = graph[i];
        while (node) {
            struct ListNode* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(graph);
    free(leaves);

    return result;
}