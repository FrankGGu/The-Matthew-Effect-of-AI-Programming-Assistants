#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node** children;
    int numChildren;
} Node;

typedef struct {
    Node* root;
} Solution;

int maxDepth(Node* root) {
    if (root == NULL) return 0;
    int maxChildDepth = 0;
    for (int i = 0; i < root->numChildren; i++) {
        int childDepth = maxDepth(root->children[i]);
        if (childDepth > maxChildDepth) {
            maxChildDepth = childDepth;
        }
    }
    return maxChildDepth + 1;
}