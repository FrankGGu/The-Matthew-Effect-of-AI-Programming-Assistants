class Solution {
private:
    TreeNode* current_new_tree_tail;

    void inorder_traverse_and_rebuild(TreeNode* node) {
        if (!node) {
            return;
        }

        inorder_traverse_and_rebuild(node->left);

        node->left = nullptr;
        current_new_tree_tail->right = node;
        current_new_tree_tail = node;

        inorder_traverse_and_rebuild(node->right);
    }

public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode* dummy_head = new TreeNode(0);
        current_new_tree_tail = dummy_head;

        inorder_traverse_and_rebuild(root);

        TreeNode* result_head = dummy_head->right;
        return result_head;
    }
};