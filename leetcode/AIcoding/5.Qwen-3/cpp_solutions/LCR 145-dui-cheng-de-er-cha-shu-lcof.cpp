#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    bool isSymmetric(TreeNode* root) {
        if (!root) return true;
        return isSame(root->left, root->right);
    }

private:
    bool isSame(TreeNode* left, TreeNode* right) {
        if (!left && !right) return true;
        if (!left || !right) return false;
        return (left->val == right->val) && isSame(left->left, right->right) && isSame(left->right, right->left);
    }
};