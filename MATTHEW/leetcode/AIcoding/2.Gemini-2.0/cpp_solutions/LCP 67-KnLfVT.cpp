#include <vector>
#include <queue>

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
    TreeNode* decorateTree(TreeNode* root, vector<vector<int>>& operations) {
        if (!root) return nullptr;

        vector<pair<TreeNode*, int>> nodes;
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            nodes.push_back({node, node->val});
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }

        for (auto& op : operations) {
            int target = op[0];
            int newVal = op[1];
            for (auto& p : nodes) {
                if (p.second == target) {
                    p.first->val = newVal;
                }
            }
        }

        return root;
    }
};