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
    int maxPathSum(TreeNode* root) {
        int maxSum = INT_MIN;
        maxPathSumHelper(root, maxSum);
        return maxSum;
    }

private:
    int maxPathSumHelper(TreeNode* node, int& maxSum) {
        if (!node) return 0;

        int left = max(0, maxPathSumHelper(node->left, maxSum));
        int right = max(0, maxPathSumHelper(node->right, maxSum));

        int currentMax = node->val + left + right;
        maxSum = max(maxSum, currentMax);

        return node->val + max(left, right);
    }
};