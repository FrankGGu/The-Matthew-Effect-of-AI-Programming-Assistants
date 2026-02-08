#include <vector>
#include <algorithm>

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
    int sufficientSubset(TreeNode* root, int limit) {
        bool removed = false;
        removeInsufficientNodes(root, limit, 0, removed);
        return removed ? nullptr : root;
    }

private:
    bool removeInsufficientNodes(TreeNode* node, int limit, int currentSum, bool& removed) {
        if (!node) return true;

        if (!node->left && !node->right) {
            if (currentSum + node->val < limit) {
                removed = true;
                return true;
            } else {
                return false;
            }
        }

        bool leftRemoved = false;
        bool rightRemoved = false;
        bool leftInsufficient = removeInsufficientNodes(node->left, limit, currentSum + node->val, leftRemoved);
        bool rightInsufficient = removeInsufficientNodes(node->right, limit, currentSum + node->val, rightRemoved);

        if (leftInsufficient) {
            node->left = nullptr;
        }
        if (rightInsufficient) {
            node->right = nullptr;
        }

        if (leftInsufficient && rightInsufficient && currentSum + node->val < limit) {
            removed = true;
            return true;
        }

        return false;
    }
};