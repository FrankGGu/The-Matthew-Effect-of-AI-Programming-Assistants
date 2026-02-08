#include <iostream>
#include <vector>
#include <climits>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    bool isValidBST(TreeNode* root) {
        return isValidBST(root, LONG_MIN, LONG_MAX);
    }

private:
    bool isValidBST(TreeNode* node, long minVal, long maxVal) {
        if (node == nullptr) {
            return true;
        }
        if (node->val <= minVal || node->val >= maxVal) {
            return false;
        }
        return isValidBST(node->left, minVal, node->val) && isValidBST(node->right, node->val, maxVal);
    }
};