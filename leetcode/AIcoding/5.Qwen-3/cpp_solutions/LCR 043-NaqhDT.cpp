#include <iostream>
#include <vector>
#include <queue>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    TreeNode* insertIntoMaxHeap(TreeNode* root, int val) {
        if (!root) {
            return new TreeNode(val);
        }

        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();

            if (!node->left) {
                node->left = new TreeNode(val);
                return root;
            } else {
                q.push(node->left);
            }

            if (!node->right) {
                node->right = new TreeNode(val);
                return root;
            } else {
                q.push(node->right);
            }
        }

        return root;
    }
};