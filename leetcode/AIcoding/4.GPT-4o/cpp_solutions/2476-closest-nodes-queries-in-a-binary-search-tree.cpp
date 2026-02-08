#include <vector>
#include <algorithm>
#include <unordered_map>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class BST {
public:
    TreeNode* root;
    BST(TreeNode* node) : root(node) {}

    void inorder(TreeNode* node, vector<int>& values) {
        if (!node) return;
        inorder(node->left, values);
        values.push_back(node->val);
        inorder(node->right, values);
    }

    pair<int, int> closest(int target) {
        if (!root) return {-1, -1};
        vector<int> values;
        inorder(root, values);
        int lower = -1, upper = -1;
        auto it = lower_bound(values.begin(), values.end(), target);
        if (it != values.end()) upper = *it;
        if (it != values.begin()) lower = *(--it);
        return {lower, upper};
    }
};

class Solution {
public:
    vector<vector<int>> closestNodes(TreeNode* root, vector<int>& queries) {
        BST bst(root);
        vector<vector<int>> result;
        for (int q : queries) {
            result.push_back({bst.closest(q).first, bst.closest(q).second});
        }
        return result;
    }
};