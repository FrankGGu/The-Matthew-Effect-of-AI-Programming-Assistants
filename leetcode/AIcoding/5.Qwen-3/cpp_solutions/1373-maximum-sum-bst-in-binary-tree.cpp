#include <iostream>
#include <vector>
#include <climits>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int maxSumBST(TreeNode* root) {
        int maxSum = 0;
        helper(root, maxSum);
        return maxSum;
    }

private:
    struct Info {
        bool isBST;
        int minVal;
        int maxVal;
        int sum;
    };

    Info helper(TreeNode* node, int& maxSum) {
        if (!node) {
            return {true, INT_MAX, INT_MIN, 0};
        }

        Info left = helper(node->left, maxSum);
        Info right = helper(node->right, maxSum);

        if (left.isBST && right.isBST && node->val > left.maxVal && node->val < right.minVal) {
            int currentSum = left.sum + right.sum + node->val;
            maxSum = max(maxSum, currentSum);
            return {true, min(node->val, left.minVal), max(node->val, right.maxVal), currentSum};
        } else {
            return {false, 0, 0, 0};
        }
    }
};