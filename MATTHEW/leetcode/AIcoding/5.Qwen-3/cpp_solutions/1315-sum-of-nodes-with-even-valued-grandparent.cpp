#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    int sumEvenGrandparent(TreeNode* root) {
        int result = 0;
        dfs(root, nullptr, nullptr, result);
        return result;
    }

private:
    void dfs(TreeNode* node, TreeNode* parent, TreeNode* grandParent, int& result) {
        if (!node) return;
        if (grandParent && grandParent->val % 2 == 0) {
            result += node->val;
        }
        dfs(node->left, node, parent, result);
        dfs(node->right, node, parent, result);
    }
};