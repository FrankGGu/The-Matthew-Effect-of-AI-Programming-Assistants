#include <vector>
#include <unordered_set>

class Solution {
public:
    std::vector<TreeNode*> forestRoots;
    std::unordered_set<int> toDeleteSet;

    TreeNode* dfs(TreeNode* node, bool isRoot) {
        if (node == nullptr) {
            return nullptr;
        }

        bool deleted = toDeleteSet.count(node->val);

        if (isRoot && !deleted) {
            forestRoots.push_back(node);
        }

        node->left = dfs(node->left, deleted);
        node->right = dfs(node->right, deleted);

        if (deleted) {
            return nullptr;
        } else {
            return node;
        }
    }

    std::vector<TreeNode*> delNodes(TreeNode* root, std::vector<int>& to_delete) {
        for (int val : to_delete) {
            toDeleteSet.insert(val);
        }

        dfs(root, true);

        return forestRoots;
    }
};