class Solution {
public:
    int findTilt(TreeNode* root) {
        int tilt = 0;
        postOrder(root, tilt);
        return tilt;
    }

private:
    int postOrder(TreeNode* node, int& tilt) {
        if (!node) return 0;
        int leftSum = postOrder(node->left, tilt);
        int rightSum = postOrder(node->right, tilt);
        tilt += abs(leftSum - rightSum);
        return leftSum + rightSum + node->val;
    }
};