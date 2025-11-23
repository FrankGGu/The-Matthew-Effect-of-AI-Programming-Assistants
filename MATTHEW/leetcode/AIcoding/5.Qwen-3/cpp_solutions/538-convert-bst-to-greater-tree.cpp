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
    TreeNode* convertBST(TreeNode* root) {
        int sum = 0;
        convertBSTHelper(root, sum);
        return root;
    }

private:
    void convertBSTHelper(TreeNode* node, int& sum) {
        if (!node) return;
        convertBSTHelper(node->right, sum);
        sum += node->val;
        node->val = sum;
        convertBSTHelper(node->left, sum);
    }
};