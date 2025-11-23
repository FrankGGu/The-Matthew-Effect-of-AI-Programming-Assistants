class Solution {
private:
    int current_sum = 0;

    void reverseInorderTraversal(TreeNode* node) {
        if (node == nullptr) {
            return;
        }

        reverseInorderTraversal(node->right);

        current_sum += node->val;
        node->val = current_sum;

        reverseInorderTraversal(node->left);
    }

public:
    TreeNode* bstToGst(TreeNode* root) {
        current_sum = 0; 
        reverseInorderTraversal(root);
        return root;
    }
};