class Solution {
public:
    int findTilt(TreeNode* root) {
        int tilt = 0;
        sumTree(root, tilt);
        return tilt;
    }

    int sumTree(TreeNode* root, int& tilt) {
        if (!root) return 0;

        int leftSum = sumTree(root->left, tilt);
        int rightSum = sumTree(root->right, tilt);

        tilt += abs(leftSum - rightSum);

        return leftSum + rightSum + root->val;
    }
};