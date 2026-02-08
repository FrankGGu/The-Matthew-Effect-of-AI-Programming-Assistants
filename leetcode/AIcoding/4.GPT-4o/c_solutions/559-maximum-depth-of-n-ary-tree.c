#include <stdio.h>
#include <stdlib.h>

struct Node {
    int val;
    struct Node** children;
    int childrenSize;
};

int maxDepth(struct Node* root) {
    if (root == NULL) return 0;
    int depth = 0;
    for (int i = 0; i < root->childrenSize; i++) {
        int childDepth = maxDepth(root->children[i]);
        if (childDepth > depth) {
            depth = childDepth;
        }
    }
    return depth + 1;
}