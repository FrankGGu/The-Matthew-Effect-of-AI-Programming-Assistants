#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct GraphNode {
    int val;
    struct GraphNode** neighbors;
    int neighborCount;
};

struct GraphNode* createGraphNode(int val) {
    struct GraphNode* node = (struct GraphNode*)malloc(sizeof(struct GraphNode));
    node->val = val;
    node->neighbors = NULL;
    node->neighborCount = 0;
    return node;
}

void addEdge(struct GraphNode* node1, struct GraphNode* node2) {
    node1->neighborCount++;
    node1->neighbors = (struct GraphNode**)realloc(node1->neighbors, node1->neighborCount * sizeof(struct GraphNode*));
    node1->neighbors[node1->neighborCount - 1] = node2;

    node2->neighborCount++;
    node2->neighbors = (struct GraphNode**)realloc(node2->neighbors, node2->neighborCount * sizeof(struct GraphNode*));
    node2->neighbors[node2->neighborCount - 1] = node1;
}

void buildGraph(struct TreeNode* root, struct GraphNode** graph) {
    if (!root) return;

    graph[root->val] = createGraphNode(root->val);

    if (root->left) {
        buildGraph(root->left, graph);
        addEdge(graph[root->val], graph[root->left->val]);
    }

    if (root->right) {
        buildGraph(root->right, graph);
        addEdge(graph[root->val], graph[root->right->val]);
    }
}

int amountOfTime(struct TreeNode* root, int start) {
    if (!root) return 0;

    struct GraphNode* graph[100001] = {NULL};
    buildGraph(root, graph);

    int maxTime = 0;
    bool visited[100001] = {false};
    int queue[100001];
    int front = 0, rear = 0;

    queue[rear++] = start;
    visited[start] = true;

    int time = 0;
    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            int u = queue[front++];
            struct GraphNode* curr = graph[u];

            for (int j = 0; j < curr->neighborCount; j++) {
                int v = curr->neighbors[j]->val;
                if (!visited[v]) {
                    visited[v] = true;
                    queue[rear++] = v;
                }
            }
        }
        maxTime = time;
        time++;
    }

    for(int i = 0; i < 100001; i++){
        if(graph[i] != NULL){
            free(graph[i]->neighbors);
            free(graph[i]);
        }
    }

    return maxTime;
}