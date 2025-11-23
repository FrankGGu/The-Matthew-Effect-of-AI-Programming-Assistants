#include <vector>
#include <unordered_set>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<TreeNode*> delNodes(TreeNode* root, vector<int>& to_delete) {
        unordered_set<int> toDeleteSet(to_delete.begin(), to_delete.end());
        vector<TreeNode*> forest;
        if (deleteNodes(root, toDeleteSet, forest)) {
            forest.push_back(root);
        }
        return forest;
    }

private:
    bool deleteNodes(TreeNode* node, unordered_set<int>& toDeleteSet, vector<TreeNode*>& forest) {
        if (!node) return false;
        bool toDelete = toDeleteSet.count(node->val);
        if (deleteNodes(node->left, toDeleteSet, forest)) {
            node->left = nullptr;
        }
        if (deleteNodes(node->right, toDeleteSet, forest)) {
            node->right = nullptr;
        }
        if (toDelete) {
            if (node->left) forest.push_back(node->left);
            if (node->right) forest.push_back(node->right);
            return true;
        }
        return false;
    }
};