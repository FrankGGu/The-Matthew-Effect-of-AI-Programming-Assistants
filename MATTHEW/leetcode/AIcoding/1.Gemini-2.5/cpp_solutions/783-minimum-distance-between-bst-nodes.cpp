class Solution {
private:
    int min_diff = INT_MAX;
    TreeNode* prev = nullptr;

public:
    void inorder(TreeNode* node) {
        if (node == nullptr) {
            return;
        }
        inorder(node->left);
        if (prev != nullptr) {
            min_diff = std::min(min_diff, node->val - prev->val);
        }
        prev = node;
        inorder(node->right);
    }

    int minDiffInBST(TreeNode* root) {
        inorder(root);
        return min_diff;
    }
};