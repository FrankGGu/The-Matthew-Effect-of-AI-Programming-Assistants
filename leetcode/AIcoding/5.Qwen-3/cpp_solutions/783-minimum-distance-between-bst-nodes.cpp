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
    int minDiffInBST(TreeNode* root) {
        int minDiff = INT_MAX;
        TreeNode* prev = nullptr;
        inorder(root, prev, minDiff);
        return minDiff;
    }

private:
    void inorder(TreeNode* node, TreeNode*& prev, int& minDiff) {
        if (!node) return;
        inorder(node->left, prev, minDiff);
        if (prev) {
            minDiff = min(minDiff, node->val - prev->val);
        }
        prev = node;
        inorder(node->right, prev, minDiff);
    }
};