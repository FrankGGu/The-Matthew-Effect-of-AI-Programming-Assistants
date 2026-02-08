#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    bool isBalanced(TreeNode* root) {
        return height(root) != -1;
    }

private:
    int height(TreeNode* node) {
        if (node == nullptr) {
            return 0;
        }
        int leftHeight = height(node->left);
        if (leftHeight == -1) {
            return -1;
        }
        int rightHeight = height(node->right);
        if (rightHeight == -1) {
            return -1;
        }
        if (abs(leftHeight - rightHeight) > 1) {
            return -1;
        }
        return max(leftHeight, rightHeight) + 1;
    }
};