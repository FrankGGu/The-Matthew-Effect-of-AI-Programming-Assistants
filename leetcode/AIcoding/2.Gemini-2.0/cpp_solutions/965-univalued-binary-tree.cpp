class Solution {
public:
    bool isUnivalTree(TreeNode* root) {
        if (!root) return true;
        int val = root->val;
        return isUnival(root, val);
    }

private:
    bool isUnival(TreeNode* root, int val) {
        if (!root) return true;
        if (root->val != val) return false;
        return isUnival(root->left, val) && isUnival(root->right, val);
    }
};