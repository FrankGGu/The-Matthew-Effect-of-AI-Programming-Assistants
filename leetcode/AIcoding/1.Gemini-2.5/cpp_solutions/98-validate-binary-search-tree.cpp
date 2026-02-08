#include <limits> // Required for std::numeric_limits

class Solution {
public:
    bool isValidBST(TreeNode* root) {
        return isValidBST(root, std::numeric_limits<long long>::min(), std::numeric_limits<long long>::max());
    }

private:
    bool isValidBST(TreeNode* node, long long minVal, long long maxVal) {
        if (!node) {
            return true;
        }

        if (node->val <= minVal || node->val >= maxVal) {
            return false;
        }

        return isValidBST(node->left, minVal, node->val) &&
               isValidBST(node->right, node->val, maxVal);
    }
};