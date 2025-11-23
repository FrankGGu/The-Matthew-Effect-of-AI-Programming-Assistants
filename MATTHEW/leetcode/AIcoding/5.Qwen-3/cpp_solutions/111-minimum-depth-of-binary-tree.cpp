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
    int minDepth(TreeNode* root) {
        if (root == NULL) {
            return 0;
        }
        if (root->left == NULL && root->right == NULL) {
            return 1;
        }
        int leftDepth = root->left ? minDepth(root->left) : INT_MAX;
        int rightDepth = root->right ? minDepth(root->right) : INT_MAX;
        return 1 + min(leftDepth, rightDepth);
    }
};