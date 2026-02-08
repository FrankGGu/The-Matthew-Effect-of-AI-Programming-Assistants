#include <unordered_set>

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
    bool findTarget(TreeNode* root, int k) {
        std::unordered_set<int> s;
        return findTargetHelper(root, k, s);
    }

private:
    bool findTargetHelper(TreeNode* node, int k, std::unordered_set<int>& s) {
        if (node == nullptr) {
            return false;
        }

        if (s.count(k - node->val)) {
            return true;
        }

        s.insert(node->val);

        return findTargetHelper(node->left, k, s) || findTargetHelper(node->right, k, s);
    }
};