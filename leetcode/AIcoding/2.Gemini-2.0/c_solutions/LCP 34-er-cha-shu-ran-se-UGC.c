#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int btreeGameWinningMove(struct TreeNode* root, int n, int x){
    int left_count = 0, right_count = 0;

    function get_count = [&](struct TreeNode* node) {
        if (!node) return 0;
        int l = get_count(node->left);
        int r = get_count(node->right);
        if (node->val == x) {
            left_count = l;
            right_count = r;
        }
        return l + r + 1;
    };

    get_count(root);

    int parent_count = n - 1 - left_count - right_count;

    return (parent_count > left_count + right_count + 1) || (left_count > parent_count + right_count + 1) || (right_count > parent_count + left_count + 1);
}