#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    char* name;
    struct TreeNode** children;
    int childrenSize;
};

struct TreeNode* createNode(char* name) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->name = strdup(name);
    node->children = NULL;
    node->childrenSize = 0;
    return node;
}

struct ThroneInheritance {
    struct TreeNode* root;
    char** dead;
    int deadSize;
};

struct ThroneInheritance* throneInheritanceCreate(char* kingName) {
    struct ThroneInheritance* ti = (struct ThroneInheritance*)malloc(sizeof(struct ThroneInheritance));
    ti->root = createNode(kingName);
    ti->dead = NULL;
    ti->deadSize = 0;
    return ti;
}

void throneInheritanceBirth(struct ThroneInheritance* ti, char* parentName, char* childName) {
    struct TreeNode* parent = ti->root;
    struct TreeNode** stack = (struct TreeNode**)malloc(100 * sizeof(struct TreeNode*));
    int top = -1;

    stack[++top] = parent;
    while (top >= 0) {
        struct TreeNode* node = stack[top--];
        if (strcmp(node->name, parentName) == 0) {
            node->childrenSize++;
            node->children = realloc(node->children, node->childrenSize * sizeof(struct TreeNode*));
            node->children[node->childrenSize - 1] = createNode(childName);
            break;
        }
        for (int i = 0; i < node->childrenSize; i++) {
            stack[++top] = node->children[i];
        }
    }
    free(stack);
}

void throneInheritanceDeath(struct ThroneInheritance* ti, char* name) {
    ti->deadSize++;
    ti->dead = realloc(ti->dead, ti->deadSize * sizeof(char*));
    ti->dead[ti->deadSize - 1] = strdup(name);
}

void dfs(struct TreeNode* node, char** result, int* returnSize, int* isDead) {
    if (node == NULL) return;
    int dead = 0;
    for (int i = 0; i < *returnSize; i++) {
        if (strcmp(node->name, isDead[i]) == 0) {
            dead = 1;
            break;
        }
    }
    if (!dead) {
        result[(*returnSize)++] = strdup(node->name);
    }
    for (int i = 0; i < node->childrenSize; i++) {
        dfs(node->children[i], result, returnSize, isDead);
    }
}

char** throneInheritanceGetInheritanceOrder(struct ThroneInheritance* ti, int* returnSize) {
    char** result = (char**)malloc(100 * sizeof(char*));
    *returnSize = 0;
    dfs(ti->root, result, returnSize, ti->dead);
    return result;
}

void throneInheritanceFree(struct ThroneInheritance* ti) {
    // Implement freeing mechanism if necessary
    free(ti);
}