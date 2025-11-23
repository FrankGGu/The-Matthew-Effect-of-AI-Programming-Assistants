#include <iostream>
#include <vector>
#include <climits>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    int longestUnivaluePath(TreeNode* root) {
        int result = 0;
        dfs(root, result);
        return result;
    }

private:
    int dfs(TreeNode* node, int& result) {
        if (!node) return 0;

        int left = dfs(node->left, result);
        int right = dfs(node->right, result);

        int leftCount = (node->left && node->left->val == node->val) ? left + 1 : 0;
        int rightCount = (node->right && node->right->val == node->val) ? right + 1 : 0;

        result = max(result, leftCount + rightCount);

        return max(leftCount, rightCount);
    }
};