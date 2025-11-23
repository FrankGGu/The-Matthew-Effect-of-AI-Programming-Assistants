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
    vector<int> flipped;
    int idx = 0;

    vector<int> flipMatchVoyage(TreeNode* root, vector<int>& voyage) {
        flipped.clear();
        idx = 0;
        if (dfs(root, voyage)) {
            return flipped;
        } else {
            return {-1};
        }
    }

    bool dfs(TreeNode* node, vector<int>& voyage) {
        if (!node) return true;
        if (node->val != voyage[idx]) return false;

        idx++;

        if (node->left && node->right && node->left->val != voyage[idx]) {
            flipped.push_back(node->val);
            swap(node->left, node->right);
        }

        if (node->left && !dfs(node->left, voyage)) return false;
        if (node->right && !dfs(node->right, voyage)) return false;

        return true;
    }
};