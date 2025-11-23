#include <iostream>
#include <vector>
#include <unordered_set>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    bool findTarget(TreeNode* root, int target) {
        unordered_set<int> seen;
        return dfs(root, target, seen);
    }

private:
    bool dfs(TreeNode* node, int target, unordered_set<int>& seen) {
        if (!node) return false;
        if (seen.find(target - node->val) != seen.end()) {
            return true;
        }
        seen.insert(node->val);
        return dfs(node->left, target, seen) || dfs(node->right, target, seen);
    }
};