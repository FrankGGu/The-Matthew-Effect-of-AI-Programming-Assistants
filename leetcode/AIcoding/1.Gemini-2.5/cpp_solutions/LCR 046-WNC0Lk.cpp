#include <vector>
#include <queue> // Not strictly needed for DFS, but common for tree problems

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
    std::vector<int> rightSideView(TreeNode* root) {
        std::vector<int> result;
        dfs(root, 0, result);
        return result;
    }

private:
    void dfs(TreeNode* node, int depth, std::vector<int>& result) {
        if (node == nullptr) {
            return;
        }

        if (depth == result.size()) {
            result.push_back(node->val);
        }

        dfs(node->right, depth + 1, result);
        dfs(node->left, depth + 1, result);
    }
};