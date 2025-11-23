class Solution {
public:
    TreeNode* pre = nullptr;
    TreeNode* head = nullptr;

    TreeNode* convert(TreeNode* root) {
        if (!root) return nullptr;

        convert(root->left);

        if (!pre) {
            head = root;
        } else {
            pre->right = root;
            root->left = pre;
        }
        pre = root;

        convert(root->right);

        return head;
    }
};