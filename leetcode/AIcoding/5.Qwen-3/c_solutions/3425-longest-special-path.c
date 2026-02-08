#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char* val;
    struct Node** children;
    int childCount;
} Node;

Node* newNode(char* val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = strdup(val);
    node->children = NULL;
    node->childCount = 0;
    return node;
}

void addEdge(Node* parent, Node* child) {
    parent->childCount++;
    parent->children = (Node**)realloc(parent->children, sizeof(Node*) * parent->childCount);
    parent->children[parent->childCount - 1] = child;
}

int dfs(Node* node, char prevChar) {
    int maxLen = 0;
    for (int i = 0; i < node->childCount; i++) {
        Node* child = node->children[i];
        if (child->val[0] > prevChar) {
            int len = 1 + dfs(child, child->val[0]);
            if (len > maxLen) {
                maxLen = len;
            }
        }
    }
    return maxLen;
}

int longestSpecialPath(char** parent, int n) {
    Node* root = newNode("");
    Node** nodes = (Node**)malloc(n * sizeof(Node*));
    for (int i = 0; i < n; i++) {
        nodes[i] = newNode(parent[i]);
    }
    for (int i = 1; i < n; i++) {
        Node* parent_node = nodes[0];
        for (int j = 0; j < n; j++) {
            if (strcmp(parent[i], nodes[j]->val) == 0) {
                parent_node = nodes[j];
                break;
            }
        }
        addEdge(parent_node, nodes[i]);
    }
    int result = dfs(root, '\0');
    for (int i = 0; i < n; i++) {
        free(nodes[i]->val);
        free(nodes[i]->children);
        free(nodes[i]);
    }
    free(nodes);
    return result;
}