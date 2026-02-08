#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    vector<int> flipMatchVoyage(TreeNode* root, vector<int>& voyage) {
        vector<int> result;
        int index = 0;
        bool success = true;
        function<bool(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return true;
            if (node->val != voyage[index++]) {
                success = false;
                return false;
            }
            if (node->left && node->right && node->left->val != voyage[index]) {
                swap(node->left, node->right);
                result.push_back(node->val);
            }
            return dfs(node->left) && dfs(node->right);
        };
        if (!dfs(root)) {
            return {-1};
        }
        return result;
    }
};