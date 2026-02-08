class Solution {
private:
    TreeNode* first_node;
    TreeNode* second_node;
    TreeNode* prev_node;

    void inorder(TreeNode* root) {
        if (root == nullptr) {
            return;
        }

        inorder(root->left);

        if (prev_node != nullptr && prev_node->val > root->val) {
            if (first_node == nullptr) {
                first_node = prev_node;
            }
            second_node = root;
        }
        prev_node = root;

        inorder(root->right);
    }

public:
    void recoverTree(TreeNode* root) {
        first_node = nullptr;
        second_node = nullptr;
        prev_node = nullptr;

        inorder(root);

        if (first_node != nullptr && second_node != nullptr) {
            int temp = first_node->val;
            first_node->val = second_node->val;
            second_node->val = temp;
        }
    }
};