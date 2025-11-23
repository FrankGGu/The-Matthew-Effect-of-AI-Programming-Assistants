#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int max_len;

typedef struct {
    int left_zigzag;
    int right_zigzag;
} ZigZagLengths;

int max(int a, int b) {
    return a > b ? a : b;
}

ZigZagLengths dfs(struct TreeNode* node) {
    if (node == NULL) {
        return (ZigZagLengths){-1, -1};
    }

    ZigZagLengths left_child_lengths = dfs(node->left);
    ZigZagLengths right_child_lengths = dfs(node->right);

    int current_left_zigzag = 1 + left_child_lengths.right_zigzag;
    int current_right_zigzag = 1 + right_child_lengths.left_zigzag;

    max_len = max(max_len, current_left_zigzag);
    max_len = max(max_len, current_right_zigzag);

    return (ZigZagLengths){current_left_zigzag, current_right_zigzag};
}

int longestZigZag(struct TreeNode* root) {
    max_len = 0;

    if (root == NULL) {
        return 0;
    }

    dfs(root);

    return max_len;
}