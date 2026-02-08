class Solution {
public:
    bool checkTree(TreeNode* root) {
        int leftChildVal = (root->left != nullptr) ? root->left->val : 0;
        int rightChildVal = (root->right != nullptr) ? root->right->val : 0;

        return root->val == (leftChildVal + rightChildVal);
    }
};