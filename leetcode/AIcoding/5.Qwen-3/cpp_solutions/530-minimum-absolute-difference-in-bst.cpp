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
    int getMinimumDifference(TreeNode* root) {
        int minDiff = INT_MAX;
        TreeNode* prev = nullptr;
        inorderTraversal(root, prev, minDiff);
        return minDiff;
    }

private:
    void inorderTraversal(TreeNode* node, TreeNode*& prev, int& minDiff) {
        if (!node) return;
        inorderTraversal(node->left, prev, minDiff);
        if (prev) {
            minDiff = min(minDiff, node->val - prev->val);
        }
        prev = node;
        inorderTraversal(node->right, prev, minDiff);
    }
};