#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node* neighbors;
    int neighborsSize;
} Node;

Node* cloneGraph(Node* node) {
    if (node == NULL) return NULL;

    Node** visited = (Node**)malloc(sizeof(Node*) * 10000);
    int visitedSize = 0;

    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->val = node->val;
    new_node->neighbors = NULL;
    new_node->neighborsSize = 0;

    visited[visitedSize++] = node;

    for (int i = 0; i < node->neighborsSize; i++) {
        Node* neighbor = node->neighbors[i];
        int found = 0;
        for (int j = 0; j < visitedSize; j++) {
            if (visited[j] == neighbor) {
                found = 1;
                break;
            }
        }
        if (!found) {
            Node* cloned_neighbor = cloneGraph(neighbor);
            new_node->neighbors = (Node*)realloc(new_node->neighbors, sizeof(Node*) * (new_node->neighborsSize + 1));
            new_node->neighbors[new_node->neighborsSize++] = cloned_neighbor;
            visited[visitedSize++] = neighbor;
        } else {
            for (int j = 0; j < visitedSize; j++) {
                if (visited[j] == neighbor) {
                    new_node->neighbors = (Node*)realloc(new_node->neighbors, sizeof(Node*) * (new_node->neighborsSize + 1));
                    new_node->neighbors[new_node->neighborsSize++] = visited[j];
                    break;
                }
            }
        }
    }

    free(visited);
    return new_node;
}