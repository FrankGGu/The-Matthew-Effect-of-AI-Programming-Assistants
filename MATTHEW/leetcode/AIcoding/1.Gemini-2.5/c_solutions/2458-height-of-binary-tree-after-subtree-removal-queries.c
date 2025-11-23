#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_NODES 100005

int height[MAX_NODES]; // Stores height of subtree rooted at node->val
int depth[MAX_NODES];  // Stores depth of node->val from root (root depth 0)
int ans[MAX_NODES];    // Stores the answer for each node->val

int max(int a, int b) {
    return (a > b) ? a : b;
}

int calculate_height_and_depth(struct TreeNode* node, int current_depth) {
    if (node == NULL) {
        return -1; // Height of a NULL subtree is -1
    }

    depth[node->val] = current_depth;

    int left_h = calculate_height_and_depth(node->left, current_depth + 1);
    int right_h = calculate_height_and_depth(node->right, current_depth + 1);

    height[node->val] = 1 + max(left_h, right_h); // Store actual height
    return height[node->val];
}

void calculate_ans(struct TreeNode* node, int max_depth_from_root_excluding_u_subtree) {
    if (node == NULL) {
        return;
    }

    // The answer for removing node->val's subtree is max_depth_from_root_excluding_u_subtree
    ans[node->val] = max_depth_from_root_excluding_u_subtree;

    // Get height of left and right children's subtrees
    int left_child_h = (node->left != NULL) ? height[node->left->val] : -1;
    int right_child_h = (node->right != NULL) ? height[node->right->val] : -1;

    // Calculate max_depth_from_root_excluding_u_subtree for left child
    if (node->left != NULL) {
        // For left child, the max depth from root excluding its subtree is max of:
        // 1. The max depth from root excluding current node's subtree (max_depth_from_root_excluding_u_subtree)
        // 2. The max depth in the right sibling's subtree (depth[node->val] + 1 + right_child_h)
        calculate_ans(node->left, max(max_depth_from_root_excluding_u_subtree, depth[node->val] + 1 + right_child_h));
    }

    // Calculate max_depth_from_root_excluding_u_subtree for right child
    if (node->right != NULL) {
        // Similar logic for right child
        calculate_ans(node->right, max(max_depth_from_root_excluding_u_subtree, depth[node->val] + 1 + left_child_h));
    }
}

int* treeQueries(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    // Explicitly initialize height, depth, and ans arrays
    for (int i = 0; i < MAX_NODES; ++i) {
        height[i] = -1;
        ans[i] = -1; 
        depth[i] = -1; 
    }

    // First DFS to calculate subtree heights and node depths
    calculate_height_and_depth(root, 0); // Root is at depth 0

    // Second DFS to calculate answers for each node removal
    // Initial call for root: max_depth_from_root_excluding_u_subtree = -1 (if root is removed, tree is empty, height -1)
    calculate_ans(root, -1);

    // Prepare the result array
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; ++i) {
        result[i] = ans[queries[i]];
    }

    return result;
}