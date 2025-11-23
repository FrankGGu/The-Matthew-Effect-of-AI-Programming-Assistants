#include <algorithm>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    pair<int, int> robHelper(TreeNode* root) {
        if (!root) return {0, 0};
        auto left = robHelper(root->left);
        auto right = robHelper(root->right);
        int robCurrent = root->val + left.second + right.second;
        int skipCurrent = max(left.first, left.second) + max(right.first, right.second);
        return {robCurrent, skipCurrent};
    }

    int rob(TreeNode* root) {
        auto result = robHelper(root);
        return max(result.first, result.second);
    }
};