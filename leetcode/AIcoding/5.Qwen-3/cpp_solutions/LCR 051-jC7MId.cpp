#include <iostream>
#include <vector>
#include <algorithm>
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
        maxPathDown(root, maxSum);
        return maxSum;
    }

private:
    int maxPathDown(TreeNode* node, int& maxSum) {
        if (!node) return 0;

        int left = max(0, maxPathDown(node->left, maxSum));
        int right = max(0, maxPathDown(node->right, maxSum));

        maxSum = max(maxSum, left + right + node->val);

        return node->val + max(left, right);
    }
};