#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string smallestFromLeaf(TreeNode* root) {
        string result;
        dfs(root, "", result);
        return result;
    }

private:
    void dfs(TreeNode* node, string current, string& result) {
        if (!node) return;
        current = char('a' + node->val) + current;
        if (!node->left && !node->right) {
            if (result.empty() || current < result) {
                result = current;
            }
            return;
        }
        dfs(node->left, current, result);
        dfs(node->right, current, result);
    }
};