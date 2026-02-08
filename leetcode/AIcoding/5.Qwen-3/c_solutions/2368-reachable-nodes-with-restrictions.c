#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node* left;
    struct Node* right;
} TreeNode;

typedef struct {
    int* data;
    int size;
} Set;

Set* createSet(int capacity) {
    Set* s = (Set*)malloc(sizeof(Set));
    s->data = (int*)malloc(capacity * sizeof(int));
    s->size = 0;
    return s;
}

void addElement(Set* s, int value) {
    for (int i = 0; i < s->size; i++) {
        if (s->data[i] == value) return;
    }
    s->data[s->size++] = value;
}

int contains(Set* s, int value) {
    for (int i = 0; i < s->size; i++) {
        if (s->data[i] == value) return 1;
    }
    return 0;
}

void freeSet(Set* s) {
    free(s->data);
    free(s);
}

int dfs(TreeNode* node, Set* restrictedSet) {
    if (!node || contains(restrictedSet, node->val)) return 0;
    return 1 + dfs(node->left, restrictedSet) + dfs(node->right, restrictedSet);
}

int reachableNodes(struct TreeNode* root, int* forbidden, int forbiddenSize) {
    Set* restrictedSet = createSet(forbiddenSize);
    for (int i = 0; i < forbiddenSize; i++) {
        addElement(restrictedSet, forbidden[i]);
    }
    int result = dfs(root, restrictedSet);
    freeSet(restrictedSet);
    return result;
}