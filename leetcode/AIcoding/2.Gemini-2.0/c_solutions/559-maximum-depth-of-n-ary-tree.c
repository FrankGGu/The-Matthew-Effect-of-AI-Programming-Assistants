#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDepth(struct Node* root) {
    if (root == NULL) {
        return 0;
    }

    int max_child_depth = 0;
    if (root->children != NULL) {
        for (int i = 0; i < root->numChildren; i++) {
            int child_depth = maxDepth(root->children[i]);
            if (child_depth > max_child_depth) {
                max_child_depth = child_depth;
            }
        }
    }

    return 1 + max_child_depth;
}