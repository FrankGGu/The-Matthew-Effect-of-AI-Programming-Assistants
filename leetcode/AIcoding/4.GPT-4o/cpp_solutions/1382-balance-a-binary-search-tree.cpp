#include <vector>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    std::vector<TreeNode*> nodes;

    void inorder(TreeNode* root) {
        if (!root) return;
        inorder(root->left);
        nodes.push_back(root);
        inorder(root->right);
    }

    TreeNode* buildBalancedBST(int start, int end) {
        if (start > end) return nullptr;
        int mid = start + (end - start) / 2;
        TreeNode* node = nodes[mid];
        node->left = buildBalancedBST(start, mid - 1);
        node->right = buildBalancedBST(mid + 1, end);
        return node;
    }

    TreeNode* balanceBST(TreeNode* root) {
        inorder(root);
        return buildBalancedBST(0, nodes.size() - 1);
    }
};