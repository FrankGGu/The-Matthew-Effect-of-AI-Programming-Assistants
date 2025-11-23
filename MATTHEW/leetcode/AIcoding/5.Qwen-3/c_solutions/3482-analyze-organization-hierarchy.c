#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char* name;
    struct Node** children;
    int childCount;
} Node;

Node* createNode(char* name) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->name = strdup(name);
    node->children = NULL;
    node->childCount = 0;
    return node;
}

void addChild(Node* parent, Node* child) {
    parent->childCount++;
    parent->children = (Node**)realloc(parent->children, sizeof(Node*) * parent->childCount);
    parent->children[parent->childCount - 1] = child;
}

void freeNode(Node* node) {
    if (node == NULL) return;
    for (int i = 0; i < node->childCount; i++) {
        freeNode(node->children[i]);
    }
    free(node->name);
    free(node->children);
    free(node);
}

char** analyzeHierarchy(char** logs, int logsSize, int* returnSize) {
    Node* root = createNode("root");
    Node* current = root;

    for (int i = 0; i < logsSize; i++) {
        char* log = logs[i];
        int depth = 0;
        while (log[depth] == '-') depth++;
        char* name = log + depth;
        while (*name == ' ') name++;

        Node* newNode = createNode(name);
        if (depth == 0) {
            freeNode(current);
            current = root;
        } else {
            Node* temp = root;
            for (int d = 1; d < depth; d++) {
                temp = temp->children[0];
            }
            addChild(temp, newNode);
        }
    }

    char** result = (char**)malloc(sizeof(char*));
    *returnSize = 0;

    void dfs(Node* node) {
        (*returnSize)++;
        result = (char**)realloc(result, sizeof(char*) * (*returnSize));
        result[*returnSize - 1] = strdup(node->name);
        for (int i = 0; i < node->childCount; i++) {
            dfs(node->children[i]);
        }
    }

    dfs(root);

    freeNode(root);
    return result;
}