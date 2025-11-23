class Solution {
public:
    int findTilt(TreeNode* root) {
        int tilt = 0;
        sumTilt(root, tilt);
        return tilt;
    }

private:
    int sumTilt(TreeNode* root, int& tilt) {
        if (!root) return 0;

        int leftSum = sumTilt(root->left, tilt);
        int rightSum = sumTilt(root->right, tilt);

        tilt += abs(leftSum - rightSum);

        return root->val + leftSum + rightSum;
    }
};