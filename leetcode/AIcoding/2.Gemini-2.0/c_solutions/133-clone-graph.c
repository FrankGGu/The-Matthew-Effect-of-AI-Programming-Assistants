#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int val;
    struct Node **neighbors;
    int neighborsSize;
};

struct Node* cloneGraph(struct Node* node) {
    if (!node) return NULL;

    struct Node* map[101] = {NULL};
    struct Node* queue[101] = {NULL};
    int head = 0, tail = 0;

    struct Node* clonedNode = (struct Node*)malloc(sizeof(struct Node));
    clonedNode->val = node->val;
    clonedNode->neighbors = NULL;
    clonedNode->neighborsSize = 0;

    map[node->val] = clonedNode;
    queue[tail++] = node;

    while (head < tail) {
        struct Node* curr = queue[head++];

        struct Node* currCloned = map[curr->val];

        if (curr->neighborsSize > 0) {
            currCloned->neighbors = (struct Node**)malloc(sizeof(struct Node*) * curr->neighborsSize);
            currCloned->neighborsSize = curr->neighborsSize;
        }

        for (int i = 0; i < curr->neighborsSize; i++) {
            struct Node* neighbor = curr->neighbors[i];

            if (!map[neighbor->val]) {
                struct Node* clonedNeighbor = (struct Node*)malloc(sizeof(struct Node));
                clonedNeighbor->val = neighbor->val;
                clonedNeighbor->neighbors = NULL;
                clonedNeighbor->neighborsSize = 0;

                map[neighbor->val] = clonedNeighbor;
                queue[tail++] = neighbor;
            }

            currCloned->neighbors[i] = map[neighbor->val];
        }
    }

    return clonedNode;
}