#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    vector<TreeNode*> delNodes(TreeNode* root, vector<int>& to_delete) {
        unordered_set<int> deleteSet(to_delete.begin(), to_delete.end());
        vector<TreeNode*> result;
        root = helper(root, deleteSet, result);
        return result;
    }

private:
    TreeNode* helper(TreeNode* node, unordered_set<int>& deleteSet, vector<TreeNode*>& result) {
        if (!node) return nullptr;
        node->left = helper(node->left, deleteSet, result);
        node->right = helper(node->right, deleteSet, result);
        if (deleteSet.find(node->val) != deleteSet.end()) {
            if (node->left) result.push_back(node->left);
            if (node->right) result.push_back(node->right);
            return nullptr;
        }
        return node;
    }
};