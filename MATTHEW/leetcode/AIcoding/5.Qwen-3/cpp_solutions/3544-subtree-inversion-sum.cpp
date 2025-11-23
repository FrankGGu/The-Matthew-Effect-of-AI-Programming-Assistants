#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    struct TreeNode {
        int val;
        TreeNode *left;
        TreeNode *right;
        TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    };

    TreeNode* invertTree(TreeNode* root) {
        if (root == nullptr) return nullptr;
        TreeNode* left = invertTree(root->left);
        TreeNode* right = invertTree(root->right);
        root->left = right;
        root->right = left;
        return root;
    }

    int sumSubtree(TreeNode* root) {
        if (root == nullptr) return 0;
        return root->val + sumSubtree(root->left) + sumSubtree(root->right);
    }

    bool checkSubtree(TreeNode* s, TreeNode* t) {
        if (s == nullptr && t == nullptr) return true;
        if (s == nullptr || t == nullptr) return false;
        return s->val == t->val && checkSubtree(s->left, t->left) && checkSubtree(s->right, t->right);
    }

    int findTarget(TreeNode* s, TreeNode* t) {
        if (s == nullptr) return 0;
        if (checkSubtree(s, t)) {
            return sumSubtree(invertTree(s));
        }
        return findTarget(s->left, t) + findTarget(s->right, t);
    }

    int subtreeInversionSum(TreeNode* s, TreeNode* t) {
        return findTarget(s, t);
    }
};