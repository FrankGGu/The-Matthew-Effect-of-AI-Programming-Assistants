#include <stdbool.h>
#include <stddef.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void findNodeInfo(struct TreeNode* node, int target, int currentDepth, struct TreeNode* parent, int* outDepth, struct TreeNode** outParent) {
    if (node == NULL) {
        return;
    }

    if (node->val == target) {
        *outDepth = currentDepth;
        *outParent = parent;
        return;
    }

    // If the target has already been found in a previous recursive call (e.g., in a sibling branch),
    // we can stop further traversal for this target.
    // This check is important if the target could appear multiple times, but for unique values it's an optimization.
    // For this problem, values are unique, so we can rely on *outDepth != -1 as a flag.
    if (*outDepth != -1) {
        return;
    }

    findNodeInfo(node->left, target, currentDepth + 1, node, outDepth, outParent);
    if (*outDepth != -1) { // Target found in left subtree, propagate early exit
        return;
    }
    findNodeInfo(node->right, target, currentDepth + 1, node, outDepth, outParent);
}

bool isCousins(struct TreeNode* root, int x, int y) {
    int depthX = -1;
    struct TreeNode* parentX = NULL;
    int depthY = -1;
    struct TreeNode* parentY = NULL;

    findNodeInfo(root, x, 0, NULL, &depthX, &parentX);
    findNodeInfo(root, y, 0, NULL, &depthY, &parentY);

    return (depthX == depthY) && (parentX != parentY);
}