#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int depth;
    struct TreeNode* parent;
} NodeInfo;

void dfs(struct TreeNode* node, struct TreeNode* parent, int depth, int target, NodeInfo* info) {
    if (node == NULL) return;

    if (node->val == target) {
        info->depth = depth;
        info->parent = parent;
        return;
    }

    dfs(node->left, node, depth + 1, target, info);
    dfs(node->right, node, depth + 1, target, info);
}

bool isCousins(struct TreeNode* root, int x, int y) {
    NodeInfo xInfo = {-1, NULL};
    NodeInfo yInfo = {-1, NULL};

    dfs(root, NULL, 0, x, &xInfo);
    dfs(root, NULL, 0, y, &yInfo);

    return (xInfo.depth == yInfo.depth) && (xInfo.parent != yInfo.parent);
}