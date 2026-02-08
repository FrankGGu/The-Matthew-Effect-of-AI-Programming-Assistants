#include <iostream>
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
    int countNodes(TreeNode* root) {
        if (!root) return 0;

        int leftDepth = 0;
        TreeNode* node = root;
        while (node->left) {
            leftDepth++;
            node = node->left;
        }

        int rightDepth = 0;
        node = root;
        while (node->right) {
            rightDepth++;
            node = node->right;
        }

        if (leftDepth == rightDepth) {
            return (1 << (leftDepth + 1)) - 1;
        } else {
            return 1 + countNodes(root->left) + countNodes(root->right);
        }
    }
};