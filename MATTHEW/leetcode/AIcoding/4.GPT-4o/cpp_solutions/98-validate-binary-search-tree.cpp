#include <limits>
struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    bool isValidBST(TreeNode* root) {
        return isValid(root, std::numeric_limits<long long>::min(), std::numeric_limits<long long>::max());
    }

private:
    bool isValid(TreeNode* node, long long minVal, long long maxVal) {
        if (!node) return true;
        if (node->val <= minVal || node->val >= maxVal) return false;
        return isValid(node->left, minVal, node->val) && isValid(node->right, node->val, maxVal);
    }
};