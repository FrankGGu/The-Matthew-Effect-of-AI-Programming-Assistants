#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    bool isCousins(TreeNode* root, int x, int y) {
        if (!root) return false;

        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int size = q.size();
            bool foundX = false;
            bool foundY = false;
            TreeNode* parentX = nullptr;
            TreeNode* parentY = nullptr;

            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();

                if (node->val == x) {
                    foundX = true;
                    parentX = node;
                }
                if (node->val == y) {
                    foundY = true;
                    parentY = node;
                }

                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }

            if (foundX && foundY) {
                return parentX != parentY;
            }
        }

        return false;
    }
};