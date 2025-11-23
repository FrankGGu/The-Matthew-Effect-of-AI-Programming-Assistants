class Solution {
private:
    TreeNode* current_node_ptr;

public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode* dummy_head = new TreeNode(0);
        current_node_ptr = dummy_head;
        inorder_traversal(root);
        return dummy_head->right;
    }

private:
    void inorder_traversal(TreeNode* node) {
        if (!node) {
            return;
        }
        inorder_traversal(node->left);

        node->left = nullptr;
        current_node_ptr->right = node;
        current_node_ptr = node;

        inorder_traversal(node->right);
    }
};