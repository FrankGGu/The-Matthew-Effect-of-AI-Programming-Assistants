#include <iostream>
#include <vector>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    TreeNode* bstToGst(TreeNode* root) {
        int sum = 0;
        traverse(root, sum);
        return root;
    }

private:
    void traverse(TreeNode* node, int& sum) {
        if (node == nullptr) return;
        traverse(node->right, sum);
        sum += node->val;
        node->val = sum;
        traverse(node->left, sum);
    }
};