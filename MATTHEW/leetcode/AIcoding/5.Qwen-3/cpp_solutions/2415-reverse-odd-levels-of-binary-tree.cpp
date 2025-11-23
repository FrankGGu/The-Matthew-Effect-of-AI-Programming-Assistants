#include <iostream>
#include <vector>
#include <queue>
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
    TreeNode* reverseOddLevels(TreeNode* root) {
        if (!root) return nullptr;

        queue<TreeNode*> q;
        q.push(root);
        int level = 0;

        while (!q.empty()) {
            int size = q.size();
            vector<int> values;
            vector<TreeNode*> nodes;

            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                nodes.push_back(node);
                values.push_back(node->val);

                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }

            if (level % 2 == 1) {
                for (int i = 0; i < nodes.size(); ++i) {
                    nodes[i]->val = values[values.size() - 1 - i];
                }
            }

            level++;
        }

        return root;
    }
};