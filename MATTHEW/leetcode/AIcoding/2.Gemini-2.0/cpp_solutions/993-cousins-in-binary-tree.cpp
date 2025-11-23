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

                if (node->left) {
                    if (node->left->val == x) {
                        foundX = true;
                        parentX = node;
                    }
                    if (node->left->val == y) {
                        foundY = true;
                        parentY = node;
                    }
                    q.push(node->left);
                }

                if (node->right) {
                    if (node->right->val == x) {
                        foundX = true;
                        parentX = node;
                    }
                    if (node->right->val == y) {
                        foundY = true;
                        parentY = node;
                    }
                    q.push(node->right);
                }
            }

            if (foundX && foundY) {
                return parentX != parentY;
            } else if (foundX || foundY) {
                return false;
            }
        }

        return false;
    }
};