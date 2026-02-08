#include <queue>

class Solution {
public:
    TreeNode* addOneRow(TreeNode* root, int val, int depth) {
        if (depth == 1) {
            TreeNode* newRoot = new TreeNode(val);
            newRoot->left = root;
            return newRoot;
        }

        std::queue<TreeNode*> q;
        if (root) {
            q.push(root);
        }

        int currentDepth = 1;
        while (!q.empty()) {
            if (currentDepth == depth - 1) {
                int levelSize = q.size();
                for (int i = 0; i < levelSize; ++i) {
                    TreeNode* node = q.front();
                    q.pop();

                    TreeNode* oldLeft = node->left;
                    node->left = new TreeNode(val);
                    node->left->left = oldLeft;

                    TreeNode* oldRight = node->right;
                    node->right = new TreeNode(val);
                    node->right->right = oldRight;
                }
                break;
            }

            int levelSize = q.size();
            for (int i = 0; i < levelSize; ++i) {
                TreeNode* node = q.front();
                q.pop();
                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
            }
            currentDepth++;
        }

        return root;
    }
};