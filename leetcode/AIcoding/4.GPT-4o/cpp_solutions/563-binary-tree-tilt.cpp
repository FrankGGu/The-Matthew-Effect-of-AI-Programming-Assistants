class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int tilt = 0;

    int sum(TreeNode* root) {
        if (!root) return 0;
        int leftSum = sum(root->left);
        int rightSum = sum(root->right);
        tilt += abs(leftSum - rightSum);
        return leftSum + rightSum + root->val;
    }

    int findTilt(TreeNode* root) {
        sum(root);
        return tilt;
    }
};