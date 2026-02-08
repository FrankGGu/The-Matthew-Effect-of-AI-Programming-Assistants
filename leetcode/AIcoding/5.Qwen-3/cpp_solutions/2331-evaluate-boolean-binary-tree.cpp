#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    bool evaluateTree(TreeNode* root) {
        if (root->val == 0 || root->val == 1) {
            return root->val;
        }
        bool left = evaluateTree(root->left);
        bool right = evaluateTree(root->right);
        if (root->val == 2) {
            return left || right;
        } else {
            return left && right;
        }
    }
};