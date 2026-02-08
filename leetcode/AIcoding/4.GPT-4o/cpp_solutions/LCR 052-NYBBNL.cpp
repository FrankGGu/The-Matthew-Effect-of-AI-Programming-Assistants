#include <iostream>
#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    TreeNode* increasingBST(TreeNode* root) {
        vector<int> vals;
        inorder(root, vals);
        TreeNode* newRoot = new TreeNode(0), *curr = newRoot;
        for (int val : vals) {
            curr->right = new TreeNode(val);
            curr = curr->right;
        }
        return newRoot->right;
    }

    void inorder(TreeNode* node, vector<int>& vals) {
        if (!node) return;
        inorder(node->left, vals);
        vals.push_back(node->val);
        inorder(node->right, vals);
    }
};