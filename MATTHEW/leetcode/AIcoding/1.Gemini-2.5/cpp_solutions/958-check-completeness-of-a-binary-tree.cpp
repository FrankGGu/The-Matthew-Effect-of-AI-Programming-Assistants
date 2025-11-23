#include <queue>

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
    bool isCompleteTree(TreeNode* root) {
        if (!root) {
            return true;
        }

        std::queue<TreeNode*> q;
        q.push(root);
        bool null_encountered = false;

        while (!q.empty()) {
            TreeNode* current = q.front();
            q.pop();

            if (current == nullptr) {
                null_encountered = true;
            } else {
                if (null_encountered) {
                    return false; // Found a non-null node after a null node
                }
                q.push(current->left);
                q.push(current->right);
            }
        }
        return true;
    }
};