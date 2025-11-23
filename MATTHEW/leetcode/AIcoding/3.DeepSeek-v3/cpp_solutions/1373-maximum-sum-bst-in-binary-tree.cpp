class Solution {
public:
    struct NodeInfo {
        bool isBST;
        int minVal;
        int maxVal;
        int sum;
        NodeInfo(bool isBST, int minVal, int maxVal, int sum) : isBST(isBST), minVal(minVal), maxVal(maxVal), sum(sum) {}
    };

    int maxSum = 0;

    NodeInfo helper(TreeNode* root) {
        if (!root) {
            return NodeInfo(true, INT_MAX, INT_MIN, 0);
        }

        auto left = helper(root->left);
        auto right = helper(root->right);

        if (left.isBST && right.isBST && root->val > left.maxVal && root->val < right.minVal) {
            int sum = root->val + left.sum + right.sum;
            maxSum = max(maxSum, sum);
            int minVal = min(root->val, left.minVal);
            int maxVal = max(root->val, right.maxVal);
            return NodeInfo(true, minVal, maxVal, sum);
        } else {
            return NodeInfo(false, 0, 0, 0);
        }
    }

    int maxSumBST(TreeNode* root) {
        helper(root);
        return maxSum;
    }
};